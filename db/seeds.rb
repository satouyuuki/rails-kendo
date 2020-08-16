# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
6.times do |i|
  Team.create(name: "名無し#{i+1}")
  School.create(name: "サンプル#{i+1}高校")
  Opponent.create(school_id: School.find(1).id, name: "相手の名前#{i+1}")
end
Match.create(school_id: School.find(1).id, place: "サンプル会場")
