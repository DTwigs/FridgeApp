# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def get_rand(num)
  num = 30 if num <= 29
  num = 45 if num >= 46

  rand((num-1)..(num+1))
end

minutes = 10
temp_rand = rand(29..46)

while minutes <= 7200 do
  temp_rand = get_rand(temp_rand)
  Temperature.create({temperature: temp_rand, created_at: DateTime.now.advance(minutes: -(minutes))})
  minutes += 10
end