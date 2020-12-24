# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  email: 'a@a',
  password: 'aaaaaa'
)

EndUser.create!(
  email: 'a@a',
  password: 'aaaaaa',
  name: '松尾イサキ'
)

EndUser.create!(
  email: 'b@b',
  password: 'bbbbbb',
  name: '野原新之助'
)

EndUser.create!(
  email: 'c@c',
  password: 'cccccc',
  name: '野比のび太'
)

EndUser.create!(
  email: 'd@d',
  password: 'dddddd',
  name: '坂田金時'
)

EndUser.create!(
  email: 'e@e',
  password: 'eeeeee',
  name: 'ヤムチャ'
)

Genre.create!(
  name: 'インテリア',
  is_active: 'true'
)
Genre.create!(
  name: '装飾品',
  is_active: 'true'
)
Genre.create!(
  name: 'アクセサリー',
  is_active: 'true'
)
Genre.create!(
  name: '棚・収納',
  is_active: 'true'
)
Genre.create!(
  name: '洋服掛け',
  is_active: 'true'
)
Genre.create!(
  name: '机・椅子',
  is_active: 'true'
)
