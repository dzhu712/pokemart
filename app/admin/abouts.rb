ActiveAdmin.register About do
  permit_params :title, :content

  form do |f|
    f.inputs "About Page Content" do
      f.input :title
      f.input :content
    end
    f.actions
  end
end
