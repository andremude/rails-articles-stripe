class CheckoutController < ApplicationController

  def create
    order = Order.find(params[:order_id])
    prices = order.articles.map do |article|
      { price: article.stripe_pricing_id, quantity: 1 }
    end

    session = Stripe::Checkout::Session.create({
      cancel_url: order_url(order),
      success_url: root_url,
      mode: 'payment',
      payment_method_types: ['card'],
      line_items: prices
    })
    redirect_to session.url, allow_other_host: true
  end
end
