# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# user for school system (master branch on git)
# User.create!(email: "admin@school.com", password: "120120", user_type: 0, password_confirmation: "120120")
# User.create!(email: "schooladmin@school.com", password: "school", user_type: 1, password_confirmation: "school")
# User.create!(email: "exams@school.com", password: "school", user_type: 2, password_confirmation: "school")
# User.create!(email: "accounts@school.com", password: "school", user_type: 3, password_confirmation: "school")


# user for optics POS system (pos branch on git)
User.create!(email: "admin@optics.com", password: "optics", user_type: 0, password_confirmation: "optics")
User.create!(email: "sale@optics.com", password: "optics", user_type: 1, password_confirmation: "optics")
Invoice.create!
Fund.create!(amount: 0)

