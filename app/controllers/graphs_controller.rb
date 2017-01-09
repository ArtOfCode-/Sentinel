class GraphsController < ApplicationController
  def posts_by_hour
    render json: Post.where('created_at > ?', 1.week.ago).group_by_hour(:created_at).count
  end

  def reason_feedback_types
    render json: Post.includes(:reasons).includes(:feedbacks).where(:reasons => { :id => params[:id] }).group('feedbacks.feedback_type_id').count.map{|k,v| [(k.nil? ? "None" : FeedbackType.find(k).name), v]}
  end

  def search_feedback_types
    render json: Post.includes(:reasons).includes(:feedbacks).where(:id => params[:ids].split(";")).group('feedbacks.feedback_type_id').count.map{|k,v| [(k.nil? ? "None" : FeedbackType.find(k).name), v]}
  end
end
