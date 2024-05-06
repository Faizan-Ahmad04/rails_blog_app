# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    @user = User.find_by(email: params[:user][:email]) || User.find_by(name: params[:user][:email])
    if @user&.valid_password?(params[:user][:password])
      sign_in(@user)
      redirect_to root_path
    else
      redirect_to new_user_session_path, alert: " "
    end 
  end
  
  

  # DELETE /resource/sign_out
  def destroy
    session.clear
    redirect_to root_path
  end

  # protected
  protected

    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :remember_me])
    end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
