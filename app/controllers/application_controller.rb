class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  # before_filter :store_location

  # def store_location
  #   if params[:controller][0..5] == "devise"
  #     session[:user_return_to] = nil
  #   else
  #     url = request.referer
  #     session[:user_return_to] = url
  #   end
  # end

  # def stored_location_for(resource_or_scope)
  #   session[:user_return_to] || super
  # end

  def after_sign_in_path_for(resource)
    # stored_location_for(resource) || posts_path
    posts_path
  end

  def after_sign_up_path_for(resource)
    introductions_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:handle, :avatar]
    devise_parameter_sanitizer.for(:account_update) << [:handle, :avatar]
  end

end
