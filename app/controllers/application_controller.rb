class ApplicationController < ActionController::Base

  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_url, alert: exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  private

  # def not_authorized
  #   if controller_name == "wikis" && action_name == "new"
  #     flash[:alert] = "You must sign up to create a new wiki."
  #     redirect_to new_user_registration_path
<<<<<<< HEAD
  #   elsif controller_name == "wikis" && action_name == "edit"
  #     flash[:alert] = "You are not authorized to edit this wiki"
  #     redirect_to root_url
  #   elsif controller_name == "wikis" && action_name == "destroy"
  #     flash[:alert] = "You are not authorized to delete this wiki"
  #     redirect_to root_url
  #   else
  #     flash[:alert] = "Not sure what happened but it did not work"
  #     redirect_to root_url
  #   end
  # end
=======
  #   else
  #     redirect_to root_url, alert: exception.message
  #   end
  # end

>>>>>>> seedingdata
end
