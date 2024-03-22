require 'pokemon_tcg_sdk'
require 'open-uri'
require 'faker'

Pokemon.configure do |config|
  config.api_key = ENV['POKEMON_TCG_API_KEY']
end

puts 'Populating Table PokemonCards.'

begin
  page = 1
  batch_size = 250
  number_of_pages = 1
  total_cards = 0

  (1..number_of_pages).each do
    pokemon_cards_data = Pokemon::Card.where(page: page, pageSize: batch_size)

    break if pokemon_cards_data.empty?

    pokemon_cards_data.each do |pokemon_card_data|
      next unless pokemon_card_data.supertype == "Pokémon"

      pokemon_card = PokemonCard.new(
        name: pokemon_card_data.name,
        description: pokemon_card_data&.flavor_text,
        price: Faker::Commerce.price(range: 1..100.0, as_string: false),
        stock_quantity: Faker::Number.between(from: 0, to: 100),
      )

      begin
        card_image = URI.open(pokemon_card_data.images.large)
        pokemon_card.image.attach(io: card_image, filename: "#{pokemon_card_data.id}.png")
      rescue OpenURI::HTTPError => e
        puts "Error fetching image for card #{pokemon_card_data.id}: #{e.message}"
        next
      end

      pokemon_card_data.types.each do |pokemon_type|
        type = Type.find_or_create_by(name: pokemon_type)
        pokemon_card.types << type
      end

      pokemon_card.save

      total_cards += 1
      puts "#{total_cards}: #{pokemon_card_data.id}"
    end

    page += 1
  end
rescue StandardError => e
  puts "An error occurred: #{e.message}"
end

puts 'Table PokemonCards has been populated.'
