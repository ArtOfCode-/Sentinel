class AuthorizedBotsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin
  before_action :set_bot, :only => [:destroy]

  def index
    @bots = AuthorizedBot.all
  end

  def new
    @bot = AuthorizedBot.new
    @bot.key = Digest::SHA256.hexdigest("#{Time.now}#{rand(0..9e9)}")
  end

  def create
    @bot = AuthorizedBot.new bot_params
    if @bot.save
      redirect_to url_for(:controller => :authorized_bots, :action => :index)
    else
      render :new
    end
  end

  def destroy
    if @bot.destroy
      flash[:success] = "Removed #{@bot.name}."
    else
      flash[:danger] = "Can't remove #{@bot.name} - get a developer to check the logs."
    end
    redirect_to url_for(:controller => :authorized_bots, :action => :index)
  end

  private
  def set_bot
    @bot = AuthorizedBot.find params[:id]
  end

  def bot_params
    params.require(:authorized_bot).permit(:name, :key)
  end
end
