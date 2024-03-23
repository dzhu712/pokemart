class Province < ApplicationRecord
  has_many :tax_histories

  validates :name, presence: true
end
