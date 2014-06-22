class PlayerController < ApplicationController
  def player
    userid = params[:uid]
    session[:userid] = userid if userid != nil
    @user = User.find(session[:userid])
    if @user.slots.count == 0
      redirect_to qrcode_url
    end
  end

  def playcount
    @song = Song.find(params[:id])
    @song.add_one_playcount
    @song.save
    render :nothing => true
  end
end