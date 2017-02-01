class ApiController < ApplicationController
  helper_method :has_more
  before_action :verify_api_key
  before_action :set_pagesize

  # Read routes

  def posts_by_url
    @results = Post.where(:link => params[:url])
    @count = @results.count
    @results = @results.order(:id => :desc).paginate(:page => params[:page], :per_page => @pagesize)
    render :posts_by_url, :formats => :json
  end

  def reasons_by_id
    @results = Reason.where(:id => params[:ids].split(";"))
    @count = @results.count
    @results = @results.order(:id => :desc).paginate(:page => params[:page], :per_page => @pagesize)
    @feedback_counts = Post.joins(:reasons).joins(:feedbacks).where(:reasons => { :id => reason.id }).group('feedbacks.feedback_type_id').count.map{ |k,v| [(k.nil? ? "None" : FeedbackType.find(k).short_code), v]}
    render :reasons_by_id, :formats => :json
  end

  # Operational methods

  def has_more(result_count, per_page, page)
    result_count > (page || 1).to_i * per_page
  end

  private
  def verify_api_key
    @key = ApiKey.find_by_key params[:key]
    unless params[:key].present? && @key.present?
      render :invalid_key, :formats => :json, :status => 403
    end
  end

  def set_pagesize
    @pagesize = [(params[:per_page] || 10).to_i, 100].min
  end
end
