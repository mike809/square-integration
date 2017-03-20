class Merchant < ApplicationRecord
  validates :access_token, presence: true, uniqueness: true
end
