class Employee < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true   
  validates :phone, presence: true
  validates :address, presence: true
  validates :department, presence: true
  validates :designation, presence: true
  validates :salary, presence: true
  validates :joining_date, presence: true  

  has_many :daily_activities, dependent: :destroy
  
  scope :wfh, -> { where(:work_type => ["wfh", "home", "Home"])}
  scope :wfo, -> { where(:work_type => ["wfo", "office", "Office"])}
  scope :no_working, -> { where(:work_type => ["no-working", "noworking", "Noworking"])}
end
