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
