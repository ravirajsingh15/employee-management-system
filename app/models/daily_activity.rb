class DailyActivity < ApplicationRecord
  belongs_to :user
  belongs_to :employee

  WORK_TYPE = %w[wfo wfh no-working]

  validates :activity_date, presence: true
  validates :work_type, inclusion: {in: WORK_TYPE}
end
