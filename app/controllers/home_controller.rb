class HomeController < ApplicationController
  def index
    @cryptos = Cryptocurrency.all
  end
end
