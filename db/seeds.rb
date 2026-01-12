# db/seeds.rb
Employee.create(name: "Ravi", email: "ravi@example.com", phone: "9876543210", address: "Mumbai", work_type: "office", last_active: Date.today)
Employee.create(name: "Anjali", email: "anjali@example.com", phone: "9876543211", address: "Delhi", work_type: "home", last_active: Date.today)
Employee.create(name: "Vikram", email: "vikram@example.com", phone: "9876543212", address: "Bangalore", work_type: "office", last_active: Date.today - 1)
Employee.create(name: "Priya", email: "priya@example.com", phone: "9876543213", address: "Kolkata", work_type: "home", last_active: Date.today)
Employee.create(name: "Rahul", email: "rahul@example.com", phone: "9876543214", address: "Chennai", work_type: "no-working", last_active: Date.today)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


require "faker"

puts "🌱 Seeding database..."

# =========================
# USERS (Login users)
# =========================
puts "Creating 40 users..."

40.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: "password123",
    phone_no: Faker::Number.number(digits: 10),
    country_iso: "IN",
    country_code: "+91"
  )
end

# =========================
# EMPLOYEES
# =========================
puts "Creating 40 employees..."

# db/seeds.rb
require 'faker'

40.times do
  Employee.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    phone: Faker::PhoneNumber.cell_phone_in_e164[0..9], # max 10 digits
    address: Faker::Address.full_address,
    work_type: ["wfo", "wfh", "no-working"].sample,
    last_active: Faker::Date.backward(days: 15),
    department: ["HR", "Sales", "IT", "Finance", "Marketing"].sample,
    designation: ["Manager", "Team Lead", "Developer", "Intern", "Analyst"].sample,
    joining_date: Faker::Date.backward(days: 365),
    salary: Faker::Number.between(from: 20000, to: 120000)
  )
end

activity_phrases = [
  "completed task on time",
  "delayed due to client meeting",
  "worked on project module",
  "attended team discussion",
  "resolved critical bugs",
  "prepared report for manager",
  "assisted colleague in task",
  "participated in training session",
  "handled urgent client request",
  "reviewed team code submissions"
]

employee_ids = Employee.pluck(:id).sample([80, Employee.count].min)
user_ids     = User.pluck(:id)

employee_ids.each do |employee_id|
  DailyActivity.find_or_create_by(
    employee_id: employee_id,
    activity_date: Date.today
  ) do |activity|

    name = Faker::Name.first_name

    activity.user_id  = user_ids.sample
    activity.work_type = %w[wfh wfo no-working].sample

    login_time  = Faker::Time.backward(days: 1, period: :morning)
    logout_time = login_time + rand(4..9).hours

    activity.login_at  = login_time
    activity.logout_at = logout_time

    phrase = activity_phrases.sample
    activity.remarks = "#{name} #{phrase}"
  end
end

puts "40 fake employees created!"

puts "✅ Seeding completed successfully!"
