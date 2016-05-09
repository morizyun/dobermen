class Project < ApplicationRecord
  # ------------------------------------------------------------------
  # Associations
  # ------------------------------------------------------------------
  belongs_to :setting_gitlab, optional: true

  # ------------------------------------------------------------------
  # Attributes
  # ------------------------------------------------------------------
  attribute :brakeman_json, :brakeman_json

  # ------------------------------------------------------------------
  # Scope
  # ------------------------------------------------------------------
  scope :active_order, -> { order(last_activity_at: :desc) }

  # ------------------------------------------------------------------
  # Class Methods
  # ------------------------------------------------------------------
  class << self
    # Insert or Update
    # @param [Gitlab::ObjectifiedHash] hash
    # @param [SettingGitLab] setting
    def upsert_by_gitlab!(hash, setting)
      attr = _convert_attributes(hash)
      attr[:setting_gitlab_id] = setting.id
      self.where(web_url: attr[:web_url]).first_or_initialize.update_attributes(attr)
    end

    private

    # Gitlab::ObjectifiedHash => attributes
    # @param [Gitlab::ObjectifiedHash] hash
    # @return [Hash]
    def _convert_attributes(hash)
      keys = [:path_with_namespace, :web_url, :http_url_to_repo, :ssh_url_to_repo, :last_activity_at]
      hash.to_h.symbolize_keys.slice(*keys)
    end
  end

  # ------------------------------------------------------------------
  # Instance Methods
  # ------------------------------------------------------------------
  # SSH repository URL which replaced of domain name
  # @return [String]
  def ssh_url_with_domain
    domain = self.setting_gitlab.try(:domain)
    domain.present? ? ssh_url_to_repo.gsub(/([:\/@])localhost([:\/])/) { "#{$1}#{domain}#{$2}" } : ssh_url_to_repo
  end

  # Web page URL which replaced of domain name
  # @return [String]
  def web_url_with_domain
    domain = self.setting_gitlab.try(:domain)
    domain.present? ? web_url.gsub(/\/localhost([:\/])/) { "/#{domain}#{$1}" } : web_url
  end
end
