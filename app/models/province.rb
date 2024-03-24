class Province < ApplicationRecord
  has_many :tax_histories
  has_many :provinces

  validates :name, presence: true

  def self.ransackable_associations(auth_object = nil)
    ["tax_histories"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "updated_at"]
  end
end
