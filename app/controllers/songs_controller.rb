class SongsController < ApplicationController
  
  before_filter :authenticate_idol!
  
  def index
    @songs = current_idol.songs
  end
  
  def new
    @song = current_idol.songs.new
    @policy = Base64.encode64({:bucket => 'guanghe-file', :expiration => (Time.now().to_i + 3600), 'save-key' => "/sounds/{filemd5}{.suffix}","allow-file-type" =>"mp3,wav","content-length-range" => "0,20480000"}.to_json).gsub("\n","")
    @signature = Digest::MD5.hexdigest(@policy+'&'+'kP34t27f602TN1hWsVomI0NxTXI=')
  end
  
  def create
    @song = Song.new(params[:song].permit!)
    if @song.save
      redirect_to root_path, :notice => "保存成功"
    else
      render :new
    end
  end
  
end