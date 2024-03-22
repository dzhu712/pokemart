class PokemonCard < ApplicationRecord
  belongs_to :type

  has_one_attached :image

  def new?
    created_at >= 3.hour.ago
  end

  def recently_updated?
    updated_at >= 3.hour.ago && created_at < 3.hour.ago
  end
end
