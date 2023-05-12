require 'rails_helper'

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
end


RSpec.describe ArticlesController, type: :controller do
  let(:user) { User.create(email: 'test@example.com', password: 'password') }

  describe "#index" do
    it "assigns last articles, free articles, and premium articles" do
      articles = create_list(:article, 10)
      last_articles = articles.sort_by(&:created_at).reverse.take(6)
      free_articles = articles.select { |article| article.price.zero? }
      premium_articles = articles.select { |article| article.price > 0 }

      get :index

      expect(assigns(:last_articles)).to eq(last_articles)
      expect(assigns(:free_articles)).to eq(free_articles)
      expect(assigns(:premium_articles)).to eq(premium_articles)
    end
  end

  describe "#show" do
    it "assigns last articles and the requested article" do
      articles = create_list(:article, 5)
      last_articles = Article.paid.order(created_at: :desc).limit(3)
      article = articles.sample
      allow(controller).to receive(:policy_scope).and_return(Article)

      get :show, params: { id: article.id }

      expect(assigns(:last_articles)).to match_array(last_articles)
      expect(assigns(:article)).to eq(article)
    end
  end

  describe "#create" do
    let(:user) { User.create(email: "test@example.com", password: "password") }

    context "when article is saved successfully" do
      it "creates a new article and redirects to the article" do
        sign_in user

        expect {
          post :create, params: { article: { title: "Test Article", body: "Lorem ipsum", price: 10, private: false } }
        }.to change(Article, :count).by(1)

        expect(response).to redirect_to(assigns(:article))
        expect(flash[:success]).to eq("Article was successfully created.")
      end
    end

    context "when article fails to save" do
      it "renders the new template and sets flash error" do
        sign_in user

        allow_any_instance_of(Article).to receive(:save!).and_raise(ActiveRecord::RecordInvalid)

        expect {
          post :create, params: { article: { title: "Test Article", body: "", price: 0, private: true } }
        }.to_not change(Article, :count)

        expect(response).to render_template(:new)
        expect(flash[:error]).to eq("Error creating article.")
      end
    end
  end

  private

  def create_list(factory, count)
    Array.new(count) { create(factory) }
  end

  def create(factory, attributes = {})
    instance = Article.new({ title: "Sample Article", body: "Sample body", price: 0, private: false }.merge(attributes))
    instance.save(validate: false)
    instance
  end
end
