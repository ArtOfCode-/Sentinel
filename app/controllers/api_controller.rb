class ApiController < ApplicationController
  helper_method :has_more
  before_action :verify_api_key
  before_action :set_pagesize

  # Read routes

  def posts_by_url
    @results = Post.where(:link => params[:url])
    @count = @results.count
    @results = @results.order(:id => :desc).paginate(:page => params[:page], :per_page => @pagesize)
    @feedback_counts = {}
    FeedbackType.joins(:feedbacks).where(:feedbacks => { :post_id => @results.map(&:id) }).group('feedbacks.post_id').group('feedback_types.short_code').count.map do |g, v|
      if @feedback_counts[g[0]].present?
        @feedback_counts[g[0]][g[1]] = v
      else
        @feedback_counts[g[0]] = { g[1] => v }
      end
    end
    render :posts_by_url, :formats => :json
  end

  def reasons_by_id
    @results = Reason.where(:id => params[:ids].split(";"))
    @count = @results.count
    @results = @results.order(:id => :desc).paginate(:page => params[:page], :per_page => @pagesize)
    @feedback_counts = Post.joins(:reasons).joins(:feedbacks).where(:reasons => { :id => reason.id }).group('feedbacks.feedback_type_id').count.map{ |k,v| [(k.nil? ? "None" : FeedbackType.find(k).short_code), v]}.to_h
    render :reasons_by_id, :formats => :json
  end

  def blacklist_stats
    @reasons = Reason.where('name LIKE \'Contains Blacklisted Word - %\'')
    @feedback_stats = Reason.where(:id => @reasons.map(&:id)).map{ |r| [r.id, Post.joins(:reasons).joins(:feedbacks).where(:reasons => { :id => r.id }).group('feedbacks.feedback_type_id').count.map{ |k,v| [(k.nil? ? "None" : FeedbackType.find(k).short_code), v]}.to_h]}.to_h
    render :blacklist_stats, :formats => :json
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
