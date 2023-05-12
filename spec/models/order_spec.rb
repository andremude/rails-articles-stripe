require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "#total" do
    let(:user) { User.create(email: "test@example.com", password: "password") }
    let(:order) { Order.create(user: user) }
    let!(:article1) { Article.create(title: "Article 1", body: "Article Body", price: 100) }
    let!(:article2) { Article.create(title: "Article 2", body: "Article Body", price: 150) }

    it "returns the total price of articles in the order" do
      order.order_items.create(article: article1)
      order.order_items.create(article: article2)

      expect(order.total).to eq(250)
    end

    it "returns 0 when the order has no articles" do
      expect(order.total).to eq(0)
    end
  end

  describe "#paid_order?" do
    let(:order) { Order.new }

    context "when the order status is 'succeeded'" do
      it "returns true" do
        order.status = "succeeded"
        expect(order.paid_order?).to be_truthy
      end
    end

    context "when the order status is not 'succeeded'" do
      it "returns false" do
        order.status = "pending"
        expect(order.paid_order?).to be_falsey
      end
    end
  end
end
