require 'faker'

p 'Creating Articles'
60.times do
  Article.create(
    title: Faker::Book.title,
    body: Faker::Lorem.paragraphs(number: 50).join("\n"),
    private: Faker::Boolean.boolean,
    price: [300, 500, 800, 1000].sample
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
