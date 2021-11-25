class CalculateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Cryptocurrency.all.each do |cc|
      cc.update(last_transaction_cost: cc.single_transaction_cost)
    end
  end
end
