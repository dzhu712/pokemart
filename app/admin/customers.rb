ActiveAdmin.register Customer do
  permit_params :username, :email, :address, :province_id, :password, :password_confirmation

  form do |f|
    f.inputs do
      f.input :username
      f.input :email
      f.input :address
      f.input :province
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :username
    column :email
    column :address
    column :province
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :username
      row :email
      row :address
      row :province
      row :created_at
      row :updated_at
    end

    active_admin_comments
  end
end
