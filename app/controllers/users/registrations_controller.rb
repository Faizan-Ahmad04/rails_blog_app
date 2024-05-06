  # # frozen_string_literal: true

  # class Users::RegistrationsController < Devise::RegistrationsController
  #   # before_action :configure_sign_up_params, only: [:create]
  #   before_action :configure_sign_up_params, only: [:create]

  #   # before_action :configure_account_update_params, only: [:update]

  #   # GET /resource/sign_up
  #   # def new
  #   #   super
  #   # end

  #   # POST /resource
  #   # def create
  #   #   super
  #   # end

  #   def create
  #     @user = User.new(name: params[:user][:name], email: params[:user][:email], password: params[:user][:password])
    
  #     if @user.email.blank? || @user.password.blank?
  #       @err="All fields are required.Try"
  #       render :new
  #       return
  #     end
      
  #     if @user.save
  #       redirect_to root_path
  #       return
  #     else
  #       @err=@user.errors.full_messages()
  #       render :new
  #     end
  #   end
    

  #   # GET /resource/edit
  #   # def edit
  #   #   super
  #   # end

  #   # PUT /resource
  #   # def update
  #   #   super
  #   # end

  #   # DELETE /resource
  #   # def destroy
  #   #   super
  #   # end

  #   # GET /resource/cancel
  #   # Forces the session data which is usually expired after sign
  #   # in to be expired now. This is useful if the user wants to
  #   # cancel oauth signing in/up in the middle of the process,
  #   # removing all OAuth session data.
  #   # def cancel
  #   #   super
  #   # end

  #   # protected

  #   # If you have extra params to permit, append them to the sanitizer.
  #   def configure_sign_up_params
  #     devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password])
  #   end

  #   # If you have extra params to permit, append them to the sanitizer.
  #   # def configure_account_update_params
  #   #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  #   # end

  #   # The path used after sign up.
  #   # def after_sign_up_path_for(resource)
  #   #   super(resource)
  #   # end

  #   # The path used after sign up for inactive accounts.
  #   # def after_inactive_sign_up_path_for(resource)
  #   #   super(resource)
  #   # end
  # end


  # app/controllers/users/registrations_controller.rb

  class Users::RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
  include RegistrationsHelper
 
  def create
    @user = User.new(name: params[:user][:name], email: params[:user][:email], password: params[:user][:password])
  
    if @user.email.blank? || @user.password.blank?
      @err = "All fields are required. Try again."
      render :new
      return
    end
    
    if @user.save
      redirect_to root_path
      return
    else
      @err = @user.errors.full_messages().join(', ')
      render :new
    end
  end
  
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password])
  end
end

