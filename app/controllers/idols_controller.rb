# coding: utf-8
class IdolsController < ApplicationController
  before_filter :authenticate_idol!, except: [:index, :show]
  
  def index
    @idols = Idol.all
  end
  
  def profile
    @resource = current_idol
    @policy = Base64.encode64({:bucket => 'guanghe-photo', :expiration => (Time.now().to_i + 3600), 'save-key' => "/avatar/{filemd5}{.suffix}","allow-file-type" =>"jpg,png,jpeg","content-length-range" => "0,20480000"}.to_json).gsub("\n","")
    @signature = Digest::MD5.hexdigest(@policy+'&'+'pWyna2F/MDYvZ8lV4ETFX7tCXu8=')
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
    :weibo_url, :wusing_url, :other_url, :description, :similar_artist, :avatar_url)
  end

end