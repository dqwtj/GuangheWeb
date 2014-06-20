class WechatController < ApplicationController
  
  def qrcode
    @code = Code.new
    userid = params[:uid]
    userid = "539d3a4cc205d4bdd2000002" if userid == nil
    session[:userid] = userid
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
      return "539d3c13c205d47f9f000001"
    elsif code == 1
      return "539d3c13c205d47f9f000001"
    elsif code == 2
      return "539d3c13c205d47f9f000001"
    elsif code == 3
      return "539d3c13c205d47f9f000001"
    elsif code == 4
      return "539d3c13c205d47f9f000001"
    elsif code == 5
      return "539d3c13c205d47f9f000001"
    elsif code == 6
      return "539d3c13c205d47f9f000001"
    elsif code == 7
      return "539d3c13c205d47f9f000001"
    elsif code == 8
      return "539d3c13c205d47f9f000001"
    elsif code == 9
      return "539d3c13c205d47f9f000001"
    else
      return "535b56fff26afb1e41000002"
    end
  end
end