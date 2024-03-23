class TaxHistory < ApplicationRecord
  belongs_to :province

  validates :province_id, presence: true
  validates :pst, :gst, :hst, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validate :at_least_one_tax_present_and_positive

  def self.ransackable_associations(auth_object = nil)
    ["province"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "gst", "hst", "id", "id_value", "province_id", "pst", "updated_at"]
  end

  private

  def at_least_one_tax_present_and_positive
    if [pst, gst, hst].all?(&:blank?)
      errors.add(:base, "at least one tax must be present")
    elsif [pst, gst, hst].none? { |tax| tax.to_f > 0 }
      errors.add(:base, "at least one tax must be greater than 0")
    end
  end
end
