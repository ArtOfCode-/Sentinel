class SearchController < ApplicationController
  before_action :authenticate_user!

  def results
    search_term = params[:q] || ""
    @results = Post.where('title LIKE ?', "%#{search_term}%")
               .or(Post.where('body LIKE ?', "%#{search_term}%"))
               .or(Post.where('username LIKE ?', "%#{search_term}%"))

    case params[:feedback]
    when "true positive"
      feedback = 1
    when "false positive"
      feedback = 2
    when "true negative"
      feedback = 3
    when "needs edit"
      feedback = 4
    end

    if feedback.present?
      @results = @results.joins(:feedbacks).where(:feedbacks => {:feedback_type_id => feedback})
    end
  
    min_score = params[:min_score].to_i || -30
    @results = @results.where('nato_score >= :score', score: min_score)
    
    @results = @results.order(:created_at => :desc).paginate(:page => params[:page], :per_page => 100)
  end
end
