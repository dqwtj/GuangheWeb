# coding: utf-8

class Wechat::ResponsesController < Wechat::ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :check_weixin_legality
  
  def show
    render :text => params[:echostr]
  end
  
  def create
    recordlog
    if params[:xml][:MsgType] == "event"
      if params[:xml][:Event] == "SCAN"
        @ticket = params[:xml][:Ticket]
        @song = Song.where(:ticket => @ticket).first
        if @song == nil
          @name = @ticket
        else
          @name = @song.name
        end
        render "qrcode", :formats => :xml
      end
    else
      render "echo", :formats => :xml
    end
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
    @wechatlog.ticket = params[:xml][:Ticket]
    @wechatlog.save
  end
  
  private
  # 根据参数校验请求是否合法，如果非法返回错误页面
  def check_weixin_legality
    array = [Rails.configuration.wechat_token, params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end 
end