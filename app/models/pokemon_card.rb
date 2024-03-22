class PokemonCard < ApplicationRecord
  has_and_belongs_to_many :types

  has_one_attached :image

  def new?
    created_at >= 3.days.ago
  end

  def recently_updated?
    updated_at >= 3.days.ago && created_at < 3.days.ago
  end
end
