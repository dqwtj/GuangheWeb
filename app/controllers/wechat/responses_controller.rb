# coding: utf-8

class Wechat::ResponsesController < Wechat::ApplicationController

  def show
    @song = Song.find params[:id]
    @idol = @song.idol
  end
  
  private
  # 根据参数校验请求是否合法，如果非法返回错误页面
  def check_weixin_legality
    array = [Rails.configuration.weixin_token, params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end 
end