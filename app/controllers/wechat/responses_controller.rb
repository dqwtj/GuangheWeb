# coding: utf-8

class Wechat::ResponsesController < Wechat::ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :check_weixin_legality
  
  def show
    render :text => params[:echostr]
  end
  
  def create
    render "echo", :formats => :xml
    recordlog
  end
  
  private
  # log
  def recordlog
    @wechatlog = Wechatlog.new()
    @wechatlog.content = params[:xml][:Content]
    @wechatlog.type = params[:xml][:MsgType]
    @wechatlog.time = Time.at(params[:xml][:CreateTime].to_i)
    @wechatlog.fromUser = params[:xml][:FromUserName]
    @wechatlog.mediaId = params[:xml][:MediaId]
    @wechatlog.createTime = params[:xml][:CreateTime]
    @wechatlog.event = params[:xml][:Event]
    @wechatlog.eventKey = params[:xml][:EventKey]
    
    @wechatlog.save
  end
  
  private
  # 根据参数校验请求是否合法，如果非法返回错误页面
  def check_weixin_legality
    array = [Rails.configuration.wechat_token, params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end 
end