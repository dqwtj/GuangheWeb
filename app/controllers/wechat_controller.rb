class WechatController < ApplicationController
  
  def qrcode
    @code = Code.new
    userid = params[:uid]
    session[:userid] = userid if userid != nil
    @user = User.find(session[:userid])
  end
  
  def qrcodev
    @code = params[:code]['code'].upcase
    @user = User.find(session[:userid])
    @message = "兑换失败，无此兑换码!"
    @target = Code.where(:code => @code)
    if @target.count > 0
      @tcode = @target.first
      if @tcode.is_used
        @message = "兑换失败，兑换码已经使用!"
      else
        songid = getSongId(@tcode.song)
        @card = Song.find(songid).cards.last
        if (@user.slots.where(:card => @card).first != nil)
          @message = "您已经拥有这首歌了，不能继续兑换"
        else
          @message = "兑换成功"
          @tcode.is_used = true 
          @user.slots.create(:card => @card)
          @user.save
          @tcode.save
        end
      end
    end
    @code = Code.new
  end
  
  def player
    @user = User.find(session[:userid])
  end
  
  def getSongId(code)
    code = code.to_i
    if code == 0
      return "53a4197ac205d4259a000002"
    elsif code == 1
      return "53a41a84c205d4b7b6000003"
    elsif code == 2
      return "53a41b39c205d481f6000002"
    elsif code == 3
      return "53a41cd2c205d4b7b6000005"
    elsif code == 4
      return "53a41dd8c205d481f6000004"
    elsif code == 5
      return "53a41edcc205d481f6000006"
    elsif code == 6
      return "53a41fefc205d4259a000005"
    elsif code == 7
      return "53a4208cc205d4b7b6000008"
    elsif code == 8
      return "53a4215cc205d4eed8000002"
    elsif code == 9
      return "53a42203c205d4259a000007"
    else
      return "539d3c13c205d47f9f000001"
    end
  end
end