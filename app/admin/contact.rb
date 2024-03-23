ActiveAdmin.register Contact do
  permit_params :title, :email, :phone

  form do |f|
    f.inputs "Contact Page Content" do
      f.input :title
      f.input :email
      f.input :phone
    end
    f.actions
  end
end
