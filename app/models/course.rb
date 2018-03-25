class Course < ApplicationRecord
  validates :currency_sign, presence: true, inclusion: { in: %w(USD),
              message: "Only supports USD currency."}
  validates :rate, presence: true, numericality: {greater_than_or_equal_to: 0.001, less_than_or_equal_to: 99999.999}
  validates :uptodate, presence: true
  validate :date_head_forward?

  def date_head_forward?
    return unless uptodate.present?
    errors.add(:uptodate, "can't be in the past") if uptodate < Time.now
  end
end
