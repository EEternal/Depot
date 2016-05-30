class Order < ActiveRecord::Base
  has_many :line_items
  validates_presence_of :name, :address, :email, :pay_type
  # validates_inclusion_of :pay_type, :in => PAYMENT_TYPES.map { |disp, value| value}

  PAYMENT_TYPES = [
    ["Check", "check"],
    ["Credit card", "cc"],
    ["Purchase order", "po"]
  ]

  def add_line_items_form_cart(cart)
    cart.items.each do |item|
      li = LineItem.form_cart_item(item)
      line_items << li
    end
  end
end
