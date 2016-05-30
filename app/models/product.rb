class Product < ActiveRecord::Base
  has_many :line_items
  validates_presence_of :title, :description, :image_url, :price
  validates_numericality_of :price
  validates_uniqueness_of :title
  # validates_format_of :image_url,
  #   :with => %r{\.(gif|jpg|png)$}i,
  #   :message => 'must be a URL for GIF, JPG or PNG image.'
  validate :price_must_be_at_least_a_cent
  validates_length_of :title, minimum:10

protected
  def price_must_be_at_least_a_cent
    errors.add(:price, 'should be at least 5') if price.nil? || price < 5
  end

end
