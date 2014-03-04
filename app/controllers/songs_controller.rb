class SongsController < ApplicationController
  
  before_filter :authenticate_idol!
  
  def index
    @songs = current_idol.songs
  end
  
  def new
    @song = current_idol.songs.new
  end
  
  def create
    @apply = Apply.new(params[:apply].permit!)
    @apply.invite_token = Time.now
    if @apply.save
      redirect_to root_path, :notice => "您的申请已经收到，我们的工作人员会尽快与您联系"
    else
      render :new
    end
  end
  
end