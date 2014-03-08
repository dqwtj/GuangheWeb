# coding: utf-8
class AccountController < Devise::RegistrationsController
  protect_from_forgery
  def edit
    super
  end

  def update
    super
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    resource.password = params[resource_name][:password]
    resource.email = params[resource_name][:email]
    @apply = Apply.where(email: resource.email).first
    resource.name = @apply.name
    resource.gender = @apply.gender
    resource.wechat = @apply.wechat
    resource.douban_url = @apply.douban_url
    resource.weibo_url = @apply.weibo_url
    resource.wusing_url = @apply.wusing_url
    resource.other_url = @apply.other_url
    resource.description = @apply.description
    resource.similar_artist = @apply.similar_artist
    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def sign_up_params
    params.require(:idol).permit(:email, :password, :password_confirmation, :invite_token)
  end

  def destroy
    super
  end
end