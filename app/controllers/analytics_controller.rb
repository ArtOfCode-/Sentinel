class AnalyticsController < ApplicationController
  before_action :verify_admin, :only => [:index]

  def index
  end

  def pageviews_over_time
    render :json => Visit.group_by_period(params[:period], :started_at, :permit => [:hour, :day, :week]).count
  end

  def pageviews_by_country
    render :json => Visit.group(:country).count
  end
end
