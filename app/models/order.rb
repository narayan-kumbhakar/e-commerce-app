class Order < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  belongs_to :user
  has_one :Payment

  enum status: {
    unpaid: 0,
    paid: 1
  }
end
