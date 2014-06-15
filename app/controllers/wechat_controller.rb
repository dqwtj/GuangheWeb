class WechatController < ApplicationController
  
  def qrcode
    @code = Code.new
  end
  
  def qrcodev
    puts Code.where(:code => params[:code]).count
  end
end