class ApiKeysController < ApplicationController
  before_action :authenticate_user!, :except => [:index]
  before_action :verify_admin, :only => [:admin_list]
  before_action :set_key, :only => [:edit, :update, :destroy]
  before_action :verify_access, :only => [:edit, :update, :destroy]

  def index
    @keys = ApiKey.all
  end

  def admin_list
    @keys = ApiKey.all
  end

  def new
    @key = ApiKey.new
    @key.key = Digest::SHA256.hexdigest("#{Time.now}#{rand(0..9e9)}")
  end

  def create
    @key = ApiKey.new key_params
    @key.user = current_user
    if @key.save
      redirect_to url_for(:controller => :api_keys, :action => :index)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @key.update key_params
      redirect_to url_for(:controller => :api_keys, :action => :index)
    else
      render :edit
    end
  end

  def destroy
    if @key.destroy
      flash[:success] = "Removed key for #{@key.name}."
    else
      flash[:danger] = "Can't delete key right now - tell a developer."
    end
    redirect_to url_for(:controller => :api_keys, :action => :index)
  end

  private
  def key_params
    params.require(:api_key).permit(:name, :key, :repo)
  end

  def set_key
    @key = ApiKey.find params[:id]
  end

  def verify_access
    unless current_user.has_role?(:admin) || current_user == @key.user
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
