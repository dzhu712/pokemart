ActiveAdmin.register PokemonCard do
  remove_filter :image_attachment, :image_blob
  permit_params :name, :description, :price, :stock_quantity, :image, type_ids: []

  form html: { enctype: "multipart/form-data" } do |f|
    f.inputs "Pokemon Card Details" do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :types, as: :check_boxes
      f.input :image, as: :file
    end
    f.actions
  end

  index do
    selectable_column
    column :image do |pokemon_card|
      image_tag url_for(pokemon_card.image), class: "admin-image" if pokemon_card.image.attached?
    end
    id_column
    column :name
    column :description do |pokemon_card|
      pokemon_card.description.presence || "N/A"
    end
    column :price
    column :stock_quantity
    column :types do |pokemon_card|
      pokemon_card.types.map(&:name).join(', ')
    end
    column :created_at
    column :updated_at
    actions
  end

  show do
    panel "Image" do
      image_tag url_for(pokemon_card.image), class: "admin-image" if pokemon_card.image.attached?
    end

    attributes_table do
      row :id
      row :name
      row :description do |pokemon_card|
        pokemon_card.description.presence || "N/A"
      end
      row :price
      row :stock_quantity
      row :types do |pokemon_card|
        pokemon_card.types.map(&:name).join(', ')
      end
      row :created_at
      row :updated_at
    end

    active_admin_comments
  end
end
