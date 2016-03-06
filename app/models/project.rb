class Project < ApplicationRecord
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
    self.where(web_url: hash[:web_url]).first_or_initialize.update_attributes(_convert_attributes(hash))
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
