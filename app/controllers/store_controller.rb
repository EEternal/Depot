class StoreController < ApplicationController
  def index
    @products = Product.all
    @time = Time.new
    if session[:counter].nil?
      session[:counter] = 0
    else
      session[:counter] += 1
    end
    @cart = find_cart
  end

  def add_to_cart
    @product = Product.find(params[:id])
    @cart = find_cart
    @current_item = @cart.add_product(@product)
    # @current_id = @product.id
    # format.js if request.xhr?
    # format.html {redirect_to_index}
    session[:counter] = 0
    flash[:notice] = "ok"
    # render js: 'alert("OK");'
    # redirect_to_index
  end

def empty_cart
  session[:cart] = nil
  redirect_to_index("Your cart is currently empty")
end

def checkout
  @cart = find_cart
  if @cart.items.empty?
    redirect_to_index("Your cart is empty")
  else
    @order = Order.new
  end
end

def save_order
  params.permit!
  @cart = find_cart
  @order = Order.new(params[:order])
  @order.add_line_items_form_cart(@cart)
  if @order.save
    session[:cart] = nil
    redirect_to_index("Thank you for your order")
  else
    render "checkout"
  end
end

private
  def redirect_to_index(msg = nil)
    flash[:notice] = msg if msg
    redirect_to :action =>'index'
  end

  def find_cart
    session[:cart] ||= Cart.new
  end

# protected
#   def authorize
#   end
end
