class Project < ApplicationRecord
  # ------------------------------------------------------------------
  # Attributes
  # ------------------------------------------------------------------
  attribute :brakeman_json, :brakeman_json

  # ------------------------------------------------------------------
  # Scope
  # ------------------------------------------------------------------
  scope :active_order, -> { order(last_activity_at: :desc) }

  # ------------------------------------------------------------------
  # Public Class Methods
  # ------------------------------------------------------------------
  # Insert or Update
  # @param [Gitlab::ObjectifiedHash] hash
  def self.upsert!(hash)
    attr = _convert_attributes(hash)
    self.where(web_url: attr[:web_url]).first_or_initialize.update_attributes(attr)
  end

  private
  # ------------------------------------------------------------------
  # Public Class Methods
  # ------------------------------------------------------------------
  # Gitlab::ObjectifiedHash => attributes
  # @param [Gitlab::ObjectifiedHash] hash
  # @return [Hash]
  def self._convert_attributes(hash)
    keys = [:path_with_namespace, :web_url, :http_url_to_repo, :ssh_url_to_repo, :last_activity_at]
    hash.to_h.symbolize_keys.slice(*keys)
  end
end
