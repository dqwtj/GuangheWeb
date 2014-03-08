# coding: utf-8

class Wechat::SongsController < Wechat::ApplicationController
  def show
    @song = Song.find params[:id]
    @idol = @song.idol
  end
end