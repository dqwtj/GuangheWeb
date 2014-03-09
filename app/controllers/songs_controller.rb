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
    if @song.url == ""
      flash[:alert] = "您未上传歌曲或歌曲没有上传完毕"
      @policy = Base64.encode64({:bucket => 'guanghe-file', :expiration => (Time.now().to_i + 3600), 'save-key' => "/sounds/{filemd5}{.suffix}","allow-file-type" =>"mp3,wav","content-length-range" => "0,20480000"}.to_json).gsub("\n","")
      @signature = Digest::MD5.hexdigest(@policy+'&'+'kP34t27f602TN1hWsVomI0NxTXI=')
      render :new
    else
      @sceneid = Song.last.sceneid
      if @sceneid == nil
        @sceneid = 0
      end
      @sceneid += 1
      @song.sceneid = @sceneid
      @song.ticket = get_ticket(@sceneid)  
      if @song.save
        redirect_to root_path, :notice => "保存成功"
      else
        render :new
      end
    end
  end

  def get_https_response(uri)
    @uri = URI.parse(uri)
    http = Net::HTTP.new(@uri.host, @uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(@uri.request_uri)
    res = http.request(request)
    return res
  end

  def post_https_response(uri, params)
    @uri = URI.parse(uri)
    http = Net::HTTP.new(@uri.host, @uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    req = Net::HTTP::Post.new(@uri.request_uri, initheader = {'Content-Type' =>'application/json'})
    req.body = params
    res = http.request(req)
    return res
  end

  def get_auth_token
    res = get_https_response("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx371fe00c9d7af74b&secret=c845a54c10a382017f1e3d0467209dab")
    return JSON.parse(res.body)['access_token']
  end

  def get_ticket(sceneid)
    auth = get_auth_token
    params = "{\"action_name\":\"QR_LIMIT_SCENE\",\"action_info\":{\"scene\":{\"scene_id\":" + sceneid.to_s + "}}}"
    res = post_https_response('https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=' +  auth, params)
    return JSON.parse(res.body)['ticket']
  end

end