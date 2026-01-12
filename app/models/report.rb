class Report < ApplicationRecord
  belongs_to :user

  # validates :from_date, :to_date, present: true
end
