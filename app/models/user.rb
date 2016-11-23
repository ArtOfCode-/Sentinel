class User < ApplicationRecord
  has_one :stack_user

  after_save :promote_if_first

  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def get_access_token(code, host)
    parameters = {
      :client_id => AppConfig[:se_client_id],
      :client_secret => AppConfig[:se_client_secret],
      :code => code,
      :redirect_uri => Rails.application.routes.url_helpers.url_for(:host => host, :controller => :se_auth, :action => :target)
    }
    response = HTTParty.post('https://stackexchange.com/oauth/access_token', :body => parameters)
    if response.code == 200
      response.parsed_response.split('=')[1]
    else
      logger.error "Access token request returned status #{response.code}: #{response.body}"
      false
    end
  end

  private
  def promote_if_first
    if self.id == 1
      self.add_role(:admin)
    end
  end
end
