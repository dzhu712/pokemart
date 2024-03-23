class PokemonCard < ApplicationRecord
  has_and_belongs_to_many :types

  has_one_attached :image

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
  validates :stock_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validate :image_presence
  validate :types_presence

  def self.ransackable_associations(auth_object = nil)
    ["image_attachment", "image_blob", "types"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "id_value", "name", "price", "stock_quantity", "updated_at"]
  end

  def new?
    created_at >= 3.days.ago
  end

  def recently_updated?
    updated_at >= 3.days.ago
  end

  private

  def image_presence
    errors.add(:image, "must be attached") unless image.attached?
  end

  def types_presence
    errors.add(:types, "must be present") if types.empty?
  end
end
