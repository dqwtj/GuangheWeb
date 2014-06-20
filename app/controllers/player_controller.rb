class PlayerController < ApplicationController
  def player
    @user = User.find(session[:userid])
  end
end