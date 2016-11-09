class SearchController < ApplicationController
  before_action :authenticate_user!

  def results
    search_term = params[:q] || ""
    @results = Post.where('title LIKE ?', "%#{search_term}%")
               .or(Post.where('body LIKE ?', "%#{search_term}%"))
               .or(Post.where('username LIKE ?', "%#{search_term}%"))
    @results = @results.order(:created_at => :desc).paginate(:page => params[:page], :per_page => 100)
  end
end
