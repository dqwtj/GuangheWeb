# coding: utf-8

class Wechat::ResponsesController < Wechat::ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :check_weixin_legality
  
  def show
    render :text => params[:echostr]
  end
  
  def create
    recordlog
  end
  
  private
  # log
  def recordlog
    puts "1111"
    @wechatlog = Wechatlog.new(:content=> params[:xml][:Content],
    :type => params[:xml][:MsgType],
    :time => Time.at(params[:xml][:CreateTime].to_i),
    :fromUser => params[:xml][:FromUserName],
    :MediaId => params[:xml][:MediaId],
    :CreateTime => params[:xml][:CreateTime],
    :event => params[:xml][:Event],
    :eventKey => params[:xml][:EventKey]
    )
    @wechatlog.save
  end
  
  private
  # 根据参数校验请求是否合法，如果非法返回错误页面
  def check_weixin_legality
    array = [Rails.configuration.wechat_token, params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end 
end