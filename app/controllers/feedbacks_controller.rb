class FeedbacksController < ApplicationController
  before_action :verify_bot_authorized, :only => [:create]
  skip_before_action :verify_authenticity_token, :only => [:create]
  before_action :set_post, :only => [:post]

  def create
    @feedback = Feedback.new feedback_params
    @feedback.feedback_type = FeedbackType.find_by_short_code(params[:feedback_type])
    if @feedback.save
      render :create, :formats => :json
    else
      render :json => { :status => "E:FEEDBACK_FAILED_TO_SAVE", :code => "500.1" }, :status => 500
    end
  end

  def post

  end

  private
  def feedback_params
    params.require(:feedback).permit(:chat_id, :chat_username, :post_id)
  end

  def set_post
    @post = Post.find params[:id]
  end
end
