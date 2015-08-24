class UsersController < ApplicationController
  include SessionHelper
  before_filter :authenticate_user!
  before_action :check_if_admin

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end

  private
    def check_if_admin
      if(is_admin?)
        return true
      else
        flash[:notice] = 'You need to be signed in to perform that action'
        redirect_to :back
      end
    end
end
