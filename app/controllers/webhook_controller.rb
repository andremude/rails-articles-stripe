class WebhookController < ApplicationController
  protect_from_forgery except: :webhook

  def receive
    event_string = request.body.read
    puts event_string
    event = Stripe::Event.construct_from(
      JSON.parse(event_string, symbolize_names: true)
    )

    if event.type.include?('payment_intent')
      payment = event.data.object
      order = Order.find_by(stripe_payment_id: payment.id)
      puts "Found order #{order.id} | #{order.status}"
      order.update!(status: payment.status)
      puts "Updated order #{order.id} | #{order.status}"
    end
  end
end
