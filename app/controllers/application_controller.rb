class ApplicationController < ActionController::Base
  #layout "store"
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authorize, :except => :login
  helper :all
  protect_from_forgery with: :exception

protected
  def authorize
    unless User.find_by_id(session[:user_id])
      session[:original_uri] = request.original_url
      #binding.pry
      flash[:notice] = "Please log in"
      redirect_to controller: :admin, action: :login
    end
  end
end
