# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!(email: "admin@scholastic.com", password: "120120", user_type: 0, password_confirmation: "120120")
User.create!(email: "schooladmin@scholastic.com", password: "scholastic", user_type: 1, password_confirmation: "scholastic")
User.create!(email: "schoolaccount@scholastic.com", password: "scholastic", user_type: 2, password_confirmation: "scholastic")
User.create!(email: "bank@scholastic.com", password: "scholastic", user_type: 3, password_confirmation: "scholastic")