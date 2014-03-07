# coding: utf-8
class IdolsController < ApplicationController
  before_filter :authenticate_idol!
  def profile
    @resource = current_idol
  end

  def update
    @resource = current_idol
    if @resource.update_attributes(update_profile_params)
      flash[:notice] = "个人资料修改成功"
      redirect_to idols_profile_path
    else
      render :profile
    end
  end

  def auth_unbind
    provider = params[:provider]

    current_user.authorizations.destroy_all({ :provider => provider })
    current_user.update_attribute(:weibo, nil)
    redirect_to edit_user_registration_path, :notice => "解除绑定成功"
  end

  def update_profile_params
    # Unsafe Email Params
    params.require(:idol).permit(:name, :gender, :wechat, :douban_url,
    :weibo_url, :wusing_url, :other_url, :description, :similar_artist)
  end

end