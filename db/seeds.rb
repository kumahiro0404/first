# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Tag.create([
    { name: 'お悩み' },
    { name: '仕事' },
    { name: '学校' },
    { name: '恋愛' },
    { name: '人間関係' },
    { name: 'その他' }
])
