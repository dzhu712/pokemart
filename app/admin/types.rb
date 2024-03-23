ActiveAdmin.register Type do
  permit_params :name

  form do |f|
    f.inputs "Types Details" do
      f.input :name
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    column :updated_at
    actions
  end
end
