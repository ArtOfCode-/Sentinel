class ApiKey < ApplicationRecord
  belongs_to :user

  validates :name, :presence => true, :length => { :minimum => 3 }
  validates :key, :presence => true, :length => { :is => 64 }
  validate  :valid_repo_url

  private
  def valid_repo_url
    return true if self.repo.nil? || self.repo.empty?
    parsed = URI.parse(self.repo)
    accepted_hosts = ["github.com", "gitlab.com", "bitbucket.org"]
    if parsed
      if accepted_hosts.include?(parsed.host)
        return true
      else
        errors.add(:repo, "host is not whitelisted")
        return false
      end
    else
      errors.add(:repo, "is not a valid URL")
      false
    end
  end
end
