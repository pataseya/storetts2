class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :categories, :brands
  helper_method :current_order


   # we don't use the before action of authenticate user because we want people to be able to view our store #without creating an account.  But we want all categories available to our navbar (the entire application) #so we put the active record call to create our collection of categories here.  And then make a before #action to call that method so we can always have the collection available in it's instance variable
   before_action :configure_permitted_parameters, if: :devise_controller?

   rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.json { head :forbidden }
        format.html { redirect_to main_app.product_url, :alert => "Not authorized!" }
      end
    end

#Our category and brand methods are below

    def categories
      @categories = Category.order(:name)
    end

    def brands
      @brands = Product.pluck(:brand).sort.uniq
    end

    def current_order
      if !session[:order_id].nil?
        Order.find(session[:order_id])
      else
        Order.new
      end
   end

   def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
     devise_parameter_sanitizer.permit(:account_update, keys: [:role])
   end

end
