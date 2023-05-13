# README

## Tech Stack
   * Ruby '2.7.4'
   * Rails '7.0.4.3'
   * PostgreSQL '12.9'

## Setup

Clone repository: `git@github.com:andremude/rails-articles-stripe.git`

<br>

Install dependencies: 

  `bundle install`

<br>

Installed Gems: 
  ```
  gem "devise"
  gem 'faker'
  gem "pundit"
  gem 'dotenv-rails', groups: [:development, :test]
  gem "stripe", "~> 8.2"
  gem 'rspec-rails', '~> 6.0.0'
  gem 'rails-controller-testing'
  ```

<br>

Database management:

  `rails db:create`

  `rails db:migrate`

  `rails db:seed`

<br>  

## Set Environment Variables 

  In `.env` file set: 

  `STRIPE_SECRET_KEY`

  `STRIPE_PUBLIC_KEY`

<br>

Run server

  `rails server`

<br>

## Stripe Payment Testing 

To test Stripe payment use card number `4242 4242 4242 4242`. 

Use a valid future date, such as 12/34.

Use any three-digit CVC.

Use any value you like for other form fields.

<br>

## RSpec Testing
  
  In Gemfile add: 
  
 ```
   group :development, :test do
     gem 'rspec-rails', '~> 6.0.0'
     gem 'rails-controller-testing'
   end
```

 In terminal: 
  
  run `bundle exec rspec`

<br>

## Screenshots

![Articleland](https://github.com/andremude/rails-articles-stripe/assets/71613801/26f6c28b-8766-4ca3-9808-14eab134948f)
