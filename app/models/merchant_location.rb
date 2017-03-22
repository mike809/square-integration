class MerchantLocation < ApplicationRecord
  belongs_to :merchant
  has_many :merchant_transactions, dependent: :destroy

  validates_presence_of :name, :square_id, :timezone

  after_create :fetch_merchant_transactions

  def fetch_merchant_transactions
    api = SquareConnect::TransactionApi.new
    response = api.list_transactions(merchant.access_token, square_id, {
      begin_time: 3.years.ago.to_datetime.rfc3339,
      end_time: Time.now.to_datetime.rfc3339
    })

    transactions = response.transactions || []
    transactions.each do |transaction|
      next if MerchantTransaction.find_by_square_id(transaction.id)

      merchant_transactions.create({
        merchant_location_id: transaction.location_id,
        square_id: transaction.id,
        transaction_date: transaction.created_at,
        product: transaction.product,
        amount_money: transaction.tenders,
        currency: transaction.tenders,
        processing_fee_money: transaction.tenders,
        notes: transaction.tenders,
      })
    end
  end

  def address=(value)
    value ||= {}
    write_attribute(:address, value.to_hash.values.join(', '))
  end
end
