class CalculateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Cryptocurrency.all.each do |cc|
      stc = cc.single_transaction_cost
      cc.update(last_transaction_cost: stc) unless stc.nil?
    end
  end
end
