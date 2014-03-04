# coding: utf-8
class Cpanel::IdolsController < Cpanel::ApplicationController
  
  def index
    @idols = Idol.paginate :page => params[:page], :per_page => 30
  end
  
  def edit
    @idol = Idol.find params[:id]
  end
  
  def update
    @idol = Idol.find params[:id]
    
    if @idol.update_attributes(params[:idol].permit!)
      redirect_to(cpanel_idols_path, :notice => '用户修改成功')
    else
      render :action => "edit"
    end
    
  end
  
end