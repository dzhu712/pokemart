require 'pokemon_tcg_sdk'
require 'open-uri'
require 'faker'

puts 'Adding Admin user.'
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
puts 'Admin user added.'


puts 'Add About Page contents.'

AboutPage.create(
  content: "Welcome to PokeMart, your premier destination for Pokémon cards! At PokeMart, we're dedicated to providing trainers with the best selection of Pokémon cards to enhance their collections, build competitive decks, and unleash their Pokémon battling skills."
)
AboutPage.create(
  title: "Our Passion",
  content: "At PokeMart, our passion for Pokémon runs deep. We understand the excitement of discovering a rare card, the thrill of completing a set, and the joy of sharing Pokémon experiences with fellow trainers. That's why we're committed to offering a diverse range of Pokémon cards, from classic favorites to the latest expansions, ensuring that every trainer finds what they're looking for."
)
AboutPage.create(
  title: "Start Your Pokémon Journey",
  content: "Ready to embark on your Pokémon journey? Explore our collection of Pokémon cards, find your favorites, and let the adventure begin. Whether you're a collector, a casual player, or a competitive battler, PokeMart has everything you need to take your Pokémon experience to the next level."
)
AboutPage.create(
  content: "Thank you for choosing PokeMart. Let's catch 'em all together!"
)

puts 'About Page contents added.'


puts 'Add Contact Page contents.'

Contact.create(
  title: "Daniel Zhu",
  email: "daniel@example.com",
  phone: "111-222-3333"
)
Contact.create(
  title: "Elon Musk",
  email: "elon@example.com",
  phone: "444-555-6666"
)
Contact.create(
  title: "Bill Gates",
  email: "bill@example.com",
  phone: "777-888-9999"
)

puts 'Contact Page contents added.'


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

puts 'Table PokemonCards populated.'
