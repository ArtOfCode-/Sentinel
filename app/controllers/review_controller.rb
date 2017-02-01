class ReviewController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_chat_linked

  def index
    @posts = Post.left_joins(:feedbacks).where(:feedbacks => { :id => nil }).limit(50)
  end

  def add_feedback
    @post = Post.find params[:post_id]
    @ft = FeedbackType.find_by_short_code params[:feedback_code]
    @feedback = Feedback.new(:feedback_type => @ft, :post => @post, :chat_id => current_user.stack_user.chat_so_id, :chat_username => current_user.username)
    if @feedback.save
      render :plain => "OK"
    else
      render :plain => "Fail", :status => 500
    end
  end

  private
  def verify_chat_linked
    unless current_user.stack_user.present?
      flash[:info] = "You need to authenticate with Stack Exchange to use review."
      redirect_to url_for(:controller => :se_auth, :action => :initiate)
    end
  end
end
