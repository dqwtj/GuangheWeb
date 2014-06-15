# coding: utf-8
class Wechat::ResponsesController < Wechat::ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :check_weixin_legality
  def show
    render :text => params[:echostr]
  end

  def create
    @action = recordlog
    @user = find_user(@action.fromUser)
    if @action.type == "event"
      if @action.event == "SCAN"
        @song = Song.where(:ticket => @action.ticket).last
        @song = Song.last if @song == nil
	puts @song.mp3_url
        render "qrcodeurl", :formats => :xml
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
    @wechatlog.body = params[:xml]
    @wechatlog.save
    return @wechatlog
  end
  
  def find_user(fromUser)
    @user = User.where(:fromUser => fromUser).first
    if @user.empty?
      @user = User.new(:fromUser => fromUser)
    end
    return @user
  end

  private

  def check_weixin_legality
    array = [Rails.configuration.wechat_token, params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end
end
