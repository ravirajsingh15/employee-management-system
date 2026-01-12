class User < ApplicationRecord
  has_secure_password

  has_one_attached :resume

  validate :resume_validation

  validates :name, presence: :true
  validates :email, presence: true, uniqueness: true
  validates :phone_no, presence: true, length: {maximum: 10}
  validates :country_code, presence: true
  validates :country_iso, presence: true

  has_many :reports, dependent: :destroy
  has_many :daily_activities, dependent: :destroy
  private

  def resume_validation
      return unless resume.attached?

      if resume.attached? && resume.byte_size > 5.megabytes
        errors.add(:resume, "Should be less than 5 MB")
      end

      allowed_types = %w[
        application/pdf
        application/msword
        application/vnd.openxmlformats-officedocument.wordprocessingml.document
      ]

      unless allowed_types.include?(resume.content_type)
        errors.add(:resume, "only PDF or Word allowed")
      end
  end
end