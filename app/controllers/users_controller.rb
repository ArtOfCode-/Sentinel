class UsersController < ApplicationController
  before_action :authenticate_user!, :only => [:promote, :demote]
  before_action :verify_admin, :only => [:promote, :demote]
  before_action :set_user, :only => [:promote, :demote]

  def index
    @users = User.all.paginate(:page => params[:page], :per_page => 50)
  end

  def promote
    @user.add_role(:admin)
    if @user.has_role?(:admin)
      flash[:success] = "Promoted #{@user.username} to admin."
    else
      flash[:danger] = "Failed to promote #{@user.username}! (Tell a developer that the has_role call after add_role failed.)"
    end
    redirect_to url_for(:controller => :users, :action => :index)
  end

  def demote
    @user.remove_role(:admin)
    unless @user.has_role?(:admin)
      flash[:success] = "Removed admin rights from #{@user.username}."
    else
      flash[:danger] = "Failed to remove admin rights from #{@user.username}! (Tell a developer that the has_role call after remove_role failed.)"
    end
    redirect_to url_for(:controller => :users, :action => :index)
  end

  private
  def set_user
    @user = User.find params[:id]
  end
end
