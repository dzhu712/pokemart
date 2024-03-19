class CreatePokemonCards < ActiveRecord::Migration[7.1]
  def change
    create_table :pokemon_cards do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.integer :stock_quantity
      t.references :type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
