class OrderItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    order_item = current_order.order_items.new(article_id: params[:article_id])
    if order_item.save
      redirect_to root_path, notice: 'Successfully added to cart.'
    else
      redirect_to root_path, alert: 'Error adding to cart.'
    end
  end

  def current_order
    order = Order.where(user_id: current_user.id, status: 'created').order(updated_at: :desc).last
    order || Order.create(user_id: current_user.id)
  end
end
