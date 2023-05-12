require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "scopes" do
    let!(:free_article) { Article.create(title: "Free Article", body: "This is a free article", private: false, price: 0) }
    let!(:paid_article) { Article.create(title: "Paid Article", body: "This is a paid article", private: true, price: 200) }

    describe ".free" do
      it "returns free articles" do
        expect(Article.free).to include(free_article)
        expect(Article.free).not_to include(paid_article)
      end
    end

    describe ".paid" do
      it "returns paid articles" do
        expect(Article.paid).to include(paid_article)
        expect(Article.paid).not_to include(free_article)
      end
    end
  end

  describe "before_save callback" do
    context "when body is present" do
      it "adds a preview" do
        article = Article.new(title: "Sample Article", body: "Lorem ipsum dolor sit amet", private: false)
        article.save
        expect(article.preview).to eq("Lorem ipsum dolor sit amet")
      end
    end

    context "when body is not present" do
      it "does not add a preview" do
        article = Article.new(title: "Sample Article", body: nil, private: false)
        article.save
        expect(article.preview).to be_nil
      end
    end
  end

  describe "after_create callback" do
    context "when article is private" do
      it "creates a Stripe product and price" do
        article = Article.new(title: "Premium Article", body: "This is a premium article", private: true)
        expect(Stripe::Product).to receive(:create).and_return(double(id: "stripe_product_id"))
        expect(Stripe::Price).to receive(:create).and_return(double(id: "stripe_pricing_id"))
        article.save
        expect(article.stripe_product_id).to eq("stripe_product_id")
        expect(article.stripe_pricing_id).to eq("stripe_pricing_id")
      end
    end

    context "when article is not private" do
      it "does not create a Stripe product and price" do
        article = Article.new(title: "Free Article", body: "This is a free article", private: false)
        expect(Stripe::Product).not_to receive(:create)
        expect(Stripe::Price).not_to receive(:create)
        article.save
        expect(article.stripe_product_id).to be_nil
        expect(article.stripe_pricing_id).to be_nil
      end
    end
  end
end
