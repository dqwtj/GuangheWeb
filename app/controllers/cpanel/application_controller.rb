# coding: utf-8
class Cpanel::ApplicationController < ApplicationController
  before_filter :authenticate_idol!
  before_filter :require_admin
  
  def require_admin
    redirect_to root_url if not ["dqwtj@yuelink.com"].include? current_idol.email
  end
  
end