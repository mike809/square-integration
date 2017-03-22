class Merchant < ApplicationRecord
  has_many :merchant_locations, dependent: :destroy

  validates :access_token, presence: true, uniqueness: true

  after_create :fetch_merchant_locations

  def fetch_merchant_locations
    api = SquareConnect::LocationApi.new
    response = api.list_locations(access_token)

    locations = response.locations || []

    locations.each do |location|
      next if MerchantLocation.find_by_square_id(location.id)
      merchant_locations.create({
        square_id: location.id,
        name: location.name,
        timezone: location.timezone,
        address: location.address
      })
    end

    merchant_locations.each(&:fetch_merchant_transactions)
  end

  def address=(address)
    address ||= {}
    address.to_hash.values.join(', ')
  end
end