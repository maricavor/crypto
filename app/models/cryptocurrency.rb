class Cryptocurrency < ApplicationRecord
  include HttpStatusCodes
  include ApiExceptions
  require 'faraday'

  CURRENCY_RATES_API_ENDPOINT = 'https://api.coincap.io/v2/assets'.freeze
  AMOUNT_OF_BYTES = 192
  AMOUNT_OF_GAS = 21000

  validates :symbol, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true

  def single_transaction_cost
    begin
      cc = current_cost
      cr = currency_rate
      if %w[BTC BSV].include? symbol 
        cc * AMOUNT_OF_BYTES.to_f * cr * 10**-8
      else
        AMOUNT_OF_GAS.to_f * cc * cr * 10**-9
      end
    rescue => e
      #p e.message
      return nil
    end
  end

  def multisig_transaction_cost
    return last_transaction_cost.to_f * multisig_factor.to_f unless multisig_factor.nil?
    "N/A"
  end
  
  private

  def current_cost
    @response = Faraday.get api_url
    if response_successful?
      parsed_response = Oj.load(@response.body)
      if symbol == "BSV" && parsed_response.has_key?("payload")
        payload = Oj.load(parsed_response["payload"])
        miningFee = payload["fees"].find{ |f| f["feeType"] == cost_attribute }["miningFee"]
        return miningFee["satoshis"].to_f / miningFee["bytes"].to_f
      else
        return nested_hash_value(parsed_response, cost_attribute).to_f
      end
    else
      raise error_class, "Symbol: #{symbol}, code: #{@response.status}, response: #{@response.body}"
    end
  end

  def currency_rate
    @response = Faraday.get CURRENCY_RATES_API_ENDPOINT
    if response_successful?
      parsed_response = Oj.load(@response.body)
      return parsed_response["data"].find{|cc| cc["symbol"] == symbol}["priceUsd"].to_f
    else
      raise error_class, "Symbol: #{symbol}, code: #{@response.status}, response: #{@response.body}"
    end
  end
 
  def nested_hash_value(obj,key)
    if obj.respond_to?(:key?) && obj.key?(key)
      obj[key]
    elsif obj.respond_to?(:each)
      r = nil
      obj.find{ |*a| r=nested_hash_value(a.last,key) }
      r
    end
  end
  
  def error_class
    case @response.status
    when HTTP_BAD_REQUEST_CODE
      BadRequestError
    when HTTP_UNAUTHORIZED_CODE
      UnauthorizedError
    when HTTP_FORBIDDEN_CODE
      return ApiRequestsQuotaReachedError if api_requests_quota_reached?
      ForbiddenError
    when HTTP_NOT_FOUND_CODE
      NotFoundError
    when HTTP_UNPROCESSABLE_ENTITY_CODE
      UnprocessableEntityError
    else
      ApiError
    end
  end

  def response_successful?
    [HTTP_OK_CODE, HTTP_CREATED_CODE].include? @response.status
  end
  
end
