class SearchController < ApplicationController
  before_action :authenticate_user!

  def results
    search_term = params[:q] || ""
    @results = Post.where('title LIKE ?', "%#{search_term}%")
               .or(Post.where('body LIKE ?', "%#{search_term}%"))
               .or(Post.where('username LIKE ?', "%#{search_term}%"))

    feedback = params[:feedback]
    if feedback.present? && feedback != "-1" # -1 signifies no specific feedback is selected.
      feedback.to_i
      @results = @results.joins(:feedbacks).where(:feedbacks => {:feedback_type_id => feedback})
    end
  
    min_score = params[:min_score].to_i || -30
    @results = @results.where('nato_score >= :score', score: min_score)
    
    @results = @results.order(:created_at => :desc).paginate(:page => params[:page], :per_page => 100)
  end
end
