require 'faker'

p 'Creating Free Articles'
30.times do
  Article.create(
    title: Faker::Book.title[0...22],
    body: Faker::Lorem.paragraphs(number: 50).join("\n"),
    private: false,
    price: 0
  )
end

p 'Creating Premium Articles'
30.times do
  Article.create(
    title: Faker::Book.title[0...22],
    body: Faker::Lorem.paragraphs(number: 50).join("\n"),
    private: true,
    price: [200, 400, 600].sample
  )
end

p 'Creating Users'
20.times do
  User.create(
    email: Faker::Internet.unique.email,
    password: '123456',
    password_confirmation: '123456'
  )
end
