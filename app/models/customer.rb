class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :province, optional: true

  validates :username, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9_-]{3,15}\z/, message: "should be 3 to 15 characters long and can only contain letters, digits, underscores, and hyphens" }
  validates :email, format: { with: /\A\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+\z/, message: "is invalid" }

  def self.ransackable_associations(auth_object = nil)
    ["province"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "email", "encrypted_password", "id", "id_value", "province_id", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at", "username"]
  end
end
