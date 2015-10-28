# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

temps = Temperature.create([{temperature: 32, created_at: DateTime.now.advance(minutes: -5)},
  {temperature: 33, created_at: DateTime.now.advance(minutes: -10)},
  {temperature: 35, created_at: DateTime.now.advance(minutes: -15)},
  {temperature: 37, created_at: DateTime.now.advance(minutes: -20)},
  {temperature: 39, created_at: DateTime.now.advance(minutes: -25)},
  {temperature: 42, created_at: DateTime.now.advance(minutes: -30)},
  {temperature: 45, created_at: DateTime.now.advance(minutes: -35)},
  {temperature: 45, created_at: DateTime.now.advance(minutes: -40)},
  {temperature: 45, created_at: DateTime.now.advance(minutes: -45)},
  {temperature: 45, created_at: DateTime.now.advance(minutes: -50)},
  {temperature: 42, created_at: DateTime.now.advance(minutes: -55)},
  {temperature: 38, created_at: DateTime.now.advance(minutes: -60)},
  {temperature: 35, created_at: DateTime.now.advance(minutes: -65)}])