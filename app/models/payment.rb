class Payment < ApplicationRecord
  belongs_to :order

  enum status: {
    completed: 0,
    failed: 1
  }
  
end
