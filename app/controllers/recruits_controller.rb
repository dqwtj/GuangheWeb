class RecruitsController < ApplicationController
  
  def create
    @recruit = Recruit.new(params[:apply].permit!)
    if @recruit.save
      redirect_to root_path, :notice => "您的申请已经收到，我们的工作人员会尽快与您联系"
    else
      render :new
    end
  end
  
end