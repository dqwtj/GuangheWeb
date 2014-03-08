class SongsController < ApplicationController
  
  #layout 'player', :only => [:show]
  before_filter :authenticate_idol!, :except => [:show]
  
  def index
    @songs = current_idol.songs
  end
  
  def new
    @song = current_idol.songs.new
    @policy = Base64.encode64({:bucket => 'guanghe-file', :expiration => (Time.now().to_i + 3600), 'save-key' => "/sounds/{filemd5}{.suffix}","allow-file-type" =>"mp3,wav","content-length-range" => "0,20480000"}.to_json).gsub("\n","")
    @signature = Digest::MD5.hexdigest(@policy+'&'+'kP34t27f602TN1hWsVomI0NxTXI=')
  end
  
  def show
    @song = Song.find params[:id]
  end
  
  def create
    @song = current_idol.songs.new(params[:song].permit!)
    if @song.url == ""
      flash[:alert] = "您未上传歌曲或歌曲没有上传完毕"
      @policy = Base64.encode64({:bucket => 'guanghe-file', :expiration => (Time.now().to_i + 3600), 'save-key' => "/sounds/{filemd5}{.suffix}","allow-file-type" =>"mp3,wav","content-length-range" => "0,20480000"}.to_json).gsub("\n","")
      @signature = Digest::MD5.hexdigest(@policy+'&'+'kP34t27f602TN1hWsVomI0NxTXI=')
      render :new
    else
      if @song.save
        redirect_to songs_path, :notice => "保存成功"
      else
        render :new
      end      
    end
  end
  
end