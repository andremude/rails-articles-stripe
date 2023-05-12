require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#current_order" do
    let(:user) { User.create(email: "test@example.com", password: "password") }

    context "when an order exists with 'created' status" do
      let!(:existing_order) { Order.create(user_id: user.id, status: "created") }

      it "returns the existing order" do
        expect(user.current_order).to eq(existing_order)
      end
    end

    context "when no order exists with 'created' status" do
      it "creates a new order" do
        expect { user.current_order }.to change { Order.count }.by(1)
      end

      it "returns the newly created order" do
        new_order = user.current_order
        expect(new_order).to be_an_instance_of(Order)
        expect(new_order.user_id).to eq(user.id)
        expect(new_order.status).to eq("created")
      end

      it "returns the most recently updated order" do
        order1 = Order.create(user_id: user.id, status: "created", updated_at: 1.day.ago)
        order2 = Order.create(user_id: user.id, status: "created", updated_at: Time.now)

        expect(user.current_order).to eq(order2)
      end
    end
  end
end
