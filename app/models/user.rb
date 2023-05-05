class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def current_order
    @current_order ||= Order.order(updated_at: :desc).find_or_create_by(user_id: id, status: 'created')
  end
end
