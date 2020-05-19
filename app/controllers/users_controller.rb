class UsersController < ApplicationController
  before_action :authenticate_user!, :except => [:index]
  before_action :verify_admin, :except => [:index]
  before_action :set_user, :except => [:index]

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

  def feedback
    @feedbacks = Feedback.joins(:post, :feedback_type).select('`posts`.`id`, `posts`.`title`, `feedbacks`.`created_at`,	`feedback_types`.`short_code`, `feedback_types`.`color`')
                 .where(:feedbacks => { :chat_username => @user.username }).order(Arel.sql('`feedbacks`.`created_at` DESC')).paginate(:page => params[:page], :per_page => 100)
  end

  def show
  end

  private
  def set_user
    @user = User.find params[:id]
  end
end
