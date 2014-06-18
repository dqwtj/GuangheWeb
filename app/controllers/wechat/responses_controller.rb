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
    session[:userid] = @user._id
    if @action.type == "event"
      if @action.event == "SCAN"
        if @action.eventKey != "888"
          @song = Song.where(:ticket => @action.ticket).last
          @song = Song.last if @song == nil
          render "qrcodeurl", :formats => :xml
        else
          render "qrcodeverify", :formats => :xml
        end
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
    if @user == nil
      @user = User.new(:fromUser => fromUser)
      @user.info = get_user_basicinfo(fromUser)
    end
    @user.last_active_time = Time.now()
    @user.save
    return @user
  end

  private

  def check_weixin_legality
    array = [Rails.configuration.wechat_token, params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end

  def get_https_response(uri)
    @uri = URI.parse(uri)
    http = Net::HTTP.new(@uri.host, @uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(@uri.request_uri)
    res = http.request(request)
    return res
  end

  def get_auth_token
    res = get_https_response("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx371fe00c9d7af74b&secret=c845a54c10a382017f1e3d0467209dab")
    return JSON.parse(res.body)['access_token']
  end

  def get_user_basicinfo(fromUser)
    auth = get_auth_token
    res = get_https_response('https://api.weixin.qq.com/cgi-bin/user/info?access_token='+auth+'&openid='+fromUser+'&lang=zh_CN')
    return JSON.parse(res.body)
  end
end
