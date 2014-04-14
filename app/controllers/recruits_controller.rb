class RecruitsController < ApplicationController
  
  def create
    @recruit = Recruit.new(params[:recruit].permit!)
    respond_to do |format|
      if @recruit.save
        format.js   {}
      else
      end
    end
  end
  
  def update
    @recruit = Recruit.find(params[:id])
    respond_to do |format|
      if @recruit.update_attributes(params[:recruit].permit!)
        format.js   {}
      else
      end
    end
  end
  
end