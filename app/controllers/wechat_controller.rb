class WechatController < ApplicationController
  
  def qrcode
    @code = Code.new
    userid = params[:uid]
    session[:userid] = userid
    puts userid
    @user = User.where(:_id=>session[:userid]).first
  end
  
  def qrcodev
    @code = params[:code]['code'].upcase
    @user = User.where(:_id=>session[:userid]).first
    @message = "兑换失败，无此兑换码!"
    @target = Code.where(:code => @code)
    if @target.count > 0
      @tcode = @target.first
      if @tcode.is_used
        @message = "兑换失败，兑换码已经使用!"
      else
        @message = "兑换成功"
        @tcode.is_used = true
        @tcode.save
      end
    end
  end
end