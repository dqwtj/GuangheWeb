class PlayerController < ApplicationController
  def player
    @user = User.find(session[:userid])
    if @user.slots.count == 0
      redirect_to qrcode_url
    end 
  end
end