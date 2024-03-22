class Type < ApplicationRecord
  has_and_belongs_to_many :pokemon_cards

  validates :name, presence: true, uniqueness: true

  def self.ransackable_associations(auth_object = nil)
    ["pokemon_cards"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "updated_at"]
  end
end
