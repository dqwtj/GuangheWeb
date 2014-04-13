# coding: utf-8
class Wechat::ActivitiesController < Wechat::ApplicationController
  def show
    @song = current_idol.songs.last
  end
end
