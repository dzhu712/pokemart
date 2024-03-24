ActiveAdmin.register TaxHistory do
  permit_params :province_id, :pst, :gst, :hst
end
