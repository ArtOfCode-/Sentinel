class PostsController < ApplicationController
  before_action :set_post, :only => [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :only => [:edit, :update, :destroy]
  before_action :verify_admin, :only => [:edit, :update, :destroy]
  before_action :verify_bot_authorized, :only => [:create]
  skip_before_action :verify_authenticity_token, :only => [:create]

  def index
    @posts = Post.all.order(:created_at => :desc).paginate(:page => params[:page], :per_page => 100)
  end

  def create
    @post = Post.new post_params
    if @post.save
      params[:reasons].each do |reason|
        @reason = Reason.find_or_create_by(name: reason)
        @reason.posts << @post
        unless @reason.save
          render :json => { :status => "E:REASON_FAILED_TO_SAVE", :code => "500.2" }, :status => 500
        end
      end
      if @post.save
        # Expire the cached Reason#most_recent values explicitly so that they update immediately
        @post.reasons.each do |reason|
          Rails.cache.delete("reason_#{reason.id}_most_recent")
        end

        render :create, :formats => :json
      else
        render :json => { :status => "E:POST_FAILED_TO_SAVE", :code => "500.3" }, :status => 500
      end
    else
      render :json => { :status => "E:POST_FAILED_TO_SAVE", :code => "500.1" }, :status => 500
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to url_for(:controller => :posts, :action => :show, :id => @post.id)
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = "Removed post #{@post.id}."
      redirect_to url_for(:controller => :posts, :action => :index)
    else
      render :show
    end
  end

  private
  def set_post
    @post = Post.find params[:id]
  end

  def post_params
    params.require(:post).permit(:title, :body, :link, :post_creation_date, :user_link, :username, :user_reputation, :nato_score)
  end
end
