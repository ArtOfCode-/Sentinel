class StackUser < ApplicationRecord
  belongs_to :user

  def update_details
    api_key = AppConfig['se_api_key']
    api_response = HTTParty.get("https://api.stackexchange.com/2.2/me?key=#{api_key}&access_token=#{self.access_token}&site=stackoverflow&filter=!bWUXTP2WcWld0F")
    if api_response.code == 200
      user_json = JSON.parse api_response.body
      self.network_id = user_json['items'][0]['account_id']
      self.username = user_json['items'][0]['display_name']

      # Haaaaaaaaack.
      self.chat_so_id = Net::HTTP.get_response(URI.parse("https://chat.stackoverflow.com/accounts/#{self.network_id}"))["location"].scan(/\/users\/(\d*)\//)[0][0]

      self.save
    else
      logger.error "/me request returned status #{api_response.code}: #{api_response.body}"
      false
    end
  end
end
