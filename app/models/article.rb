class Article < ApplicationRecord
  before_save :add_preview, if: :body?
  after_create :create_stripe_product, if: :private?
  validates :title, presence: true
  validates :body, presence: true

  scope :free, -> { where(private: false) }
  scope :paid, -> { where(private: true) }

  def add_preview
    self.preview = body[0..150]
  end

  def create_stripe_product
    # Stripe doesn't allow single quotes on statement_descriptor
    sanitized_title = title.gsub("'", "")
    product = Stripe::Product.create({ name: "Article ##{id}", statement_descriptor: sanitized_title })
    # product = Stripe::Product.create({ name: "Article ##{id}", statement_descriptor: title})
    pricing = Stripe::Price.create({
      product: product.id,
      unit_amount: price,
      currency: 'usd'
    })
    update(stripe_product_id: product.id, stripe_pricing_id: pricing.id)
  end

  def tag
    { class: tag_class, name: tag_name }
  end

  private

  def tag_name
    private ? 'Premium' : 'Free'
  end

  def tag_class
    return 'paid' unless private
    'free'
  end
end
