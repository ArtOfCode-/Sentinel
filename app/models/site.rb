class Site < ApplicationRecord
  has_many :posts

  def self.update_site_list
    require 'net/http'
    url = URI.parse('https://api.stackexchange.com/2.2/sites?pagesize=1000&filter=!*L1-85AFULD6pPxF')
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    sites = JSON.parse(res.body)["items"]
    if sites.count > 100 # all is well
      sites.each do |site|
        s = Site.find_or_create_by(:site_domain => URI.parse(site["site_url"]).host)
        s.site_url = site["site_url"]
        s.site_logo = site["favicon_url"].gsub(/https?:/, "")
        s.site_name = site["name"]
        s.is_child_meta = site["site_type"] == "meta_site"
        s.save!
      end
    end
  end
end
