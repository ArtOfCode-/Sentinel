class ReasonsController < ApplicationController
  before_action :set_reason, :except => [:index]
  before_action :authenticate_user!, :only => [:edit, :update, :destroy]
  before_action :verify_admin, :only => [:edit, :update, :destroy]

  def index
    @reasons = Reason.order('posts_count desc').paginate(:page => params[:page], :per_page => 50)
  end

  def show
    @posts = @reason.posts.order(:created_at => :desc).paginate(:page => params[:page], :per_page => 100)
    @feedback_counts = FeedbackType.all.map{|ft| [ft.short_code, ft.posts.joins(:posts_reasons).where(:posts_reasons => { :reason_id => @reason.id }).distinct.count(:id)] }
  end

  def edit
  end

  def update
    if @reason.update reason_params
      redirect_to url_for(:controller => :reasons, :action => :show, :id => @reason.id)
    else
      render :edit
    end
  end

  def destroy
    if @reason.destroy
      flash[:success] = "Removed reason #{@reason.id}."
      redirect_to url_for(:controller => :reasons, :action => :index)
    else
      render :show
    end
  end

  private
  def set_reason
    @reason = Reason.find params[:id]
  end

  def reason_params
    params.require(:reason).permit(:name)
  end
end
