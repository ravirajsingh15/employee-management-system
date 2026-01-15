class User < ApplicationRecord
  has_secure_password

  has_one_attached :resume
  
  validate :resume_validation
  validate :password_not_previously_used, on: :update
  # validates :name, presence: :true
  # validates :email, presence: true, uniqueness: true
  # validates :phone_no, presence: true, length: {maximum: 10}
  # validates :country_code, presence: true
  # validates :country_iso, presence: true

  has_many :reports, dependent: :destroy
  has_many :daily_activities, dependent: :destroy

  def generate_reset_token!
    self.reset_password_token = SecureRandom.hex(10) # random 20 char token
    self.reset_password_sent_at = Time.current
    save!
  end

  # check if token is still valid (e.g., 2 hours)
  def reset_token_valid?
      reset_password_sent_at > 2.hours.ago
  end

  # clear token after successful reset
  def clear_reset_token!
    self.reset_password_token = nil
    self.reset_password_sent_at = nil
    save!
  end

  def password_not_previously_used
    return if password.blank?

    if authenticate(password)
      errors.add(:password, 'cannot be same as your previous password')
    end
  end

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