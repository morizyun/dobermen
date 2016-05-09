class SettingGitlab < ApplicationRecord
  # ------------------------------------------------------------------
  # Constants
  # ------------------------------------------------------------------
  PER_PAGE = 10

  # ------------------------------------------------------------------
  # Attributes
  # ------------------------------------------------------------------
  attribute :ssh_key, :encryption
  attribute :private_token, :encryption

  # ------------------------------------------------------------------
  # Validations
  # ------------------------------------------------------------------
  validates :base_url, presence: true, uniqueness: true
  validates :ssh_key, presence: true
  validates :private_token, presence: true

  # ------------------------------------------------------------------
  # Callbacks
  # ------------------------------------------------------------------
  before_validation def add_last_slash
    return if self.base_url.blank?
    self.base_url = self.base_url.to_s.end_with?('/') ? self.base_url : "#{self.base_url}/"
  end

  # ------------------------------------------------------------------
  # Instance Methods
  # ------------------------------------------------------------------
  # Get all GitLab Projects
  # @return [Array<Gitlab::ObjectifiedHash>]
  def all_projects(type:)
    if type == :admin
      GitlabService.get_all_projects(self)
    else
      GitlabService.get_visible_projects(self)
    end
  end

  # Return endpoint in GitLab
  # @return [String]
  def endpoint
    "#{base_url}#{base_url =~ /\/$/ ? '' : '/'}/api/v3"
  end

  # Return domain name in GitLab
  # @return [String]
  def domain
    URI(base_url).host.downcase
  end
end
