# coding: utf-8
class Wechat::ActivitiesController < Wechat::ApplicationController
  def show
    if current_idol
      @song = current_idol.songs.last
    else
      @song = Song.last
    end
  end
end
