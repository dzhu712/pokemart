class PokemonCard < ApplicationRecord
  belongs_to :type

  has_one_attached :image
end
