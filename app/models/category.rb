class Category < ApplicationRecord
  after_create :create_stripe_product
end

def create_stripe_product
  product = Stripe::Product.create(name: name)
  pricing = Stripe::Price.create({
    product: product.id,
    unit_amount: price,
    currency: 'usd'
  })
  update(stripe_product_id: product.id, stripe_pricing_id: pricing.id)
end
