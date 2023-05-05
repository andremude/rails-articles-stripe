class OrderItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    order_item = current_user.current_order.order_items.new(article_id: params[:article_id])
    if order_item.save
      redirect_to root_path, notice: 'Successfully added to cart.'
    else
      redirect_to root_path, alert: 'Error adding to cart.'
    end
  end

  def destroy
    order_item = current_user.current_order.order_items.find(params[:id])
    order_item.destroy
    redirect_to order_item_path, notice: 'Successfully removed from cart.'
  end
end
