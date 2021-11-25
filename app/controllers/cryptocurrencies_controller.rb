class CryptocurrenciesController < ApplicationController
  before_action :set_crypto, except: [:calculate]

  def edit
  end

  def update
    respond_to do |format|
      if @crypto.update(crypto_params)
        format.html { redirect_to root_url, notice: "Cryptocurrency was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_crypto
    @crypto = Cryptocurrency.find(params[:id])
  end
  # Only allow a list of trusted parameters through.
  def crypto_params
    params.require(:cryptocurrency).permit(:symbol, :name, :api_url, :cost_attribute, :multisig_factor)
  end
end