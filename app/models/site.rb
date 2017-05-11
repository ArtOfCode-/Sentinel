class Site < ApplicationRecord
  has_many :posts

  def self.update_site_list
    require 'net/http'
    url = URI.parse('https://api.stackexchange.com/2.2/sites?pagesize=1000&filter=!*L1-85AFULD6pPxF')
    res = Net::HTTP.get_response(url)
    sites = JSON.parse(res.body)["items"]
    if sites.count > 100 # all is well
      sites.each do |site|
        s = Site.find_or_create_by(:domain => URI.parse(site["site_url"]).host)
        s.url = site["site_url"]
        s.logo = site["favicon_url"].gsub(/https?:/, "")
        s.name = site["name"]
        s.is_child_meta = site["site_type"] == "meta_site"
        s.save!
      end
    end
  end
end
