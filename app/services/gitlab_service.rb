class GitlabService
  # ------------------------------------------------------------------
  # Constants
  # ------------------------------------------------------------------
  # TODO To enable change (Having model)
  API_ENDPOINT = ENV['GITLAB_API_ENDPOINT'].freeze
  PRIVATE_TOKEN = ENV['GITLAB_PRIVATE_TOKEN'].freeze
  PER_PAGE = 10.freeze

  # ------------------------------------------------------------------
  # Public Class Methods
  # ------------------------------------------------------------------
  # Get all GitLab Projects
  # @return [Array<Gitlab::ObjectifiedHash>]
  def self.all_projects
    _get_all_projects
  end

  private
  # ------------------------------------------------------------------
  # Private Class Methods
  # ------------------------------------------------------------------
  def self._get_all_projects
    Gitlab.endpoint = API_ENDPOINT
    Gitlab.private_token = PRIVATE_TOKEN

    # listing all user name
    user_names = Gitlab.users.map(&:name)

    # get all projects
    user_names.map do |name|
      Gitlab.sudo = name
      Gitlab.projects(per_page: PER_PAGE).auto_paginate
    end.flatten.uniq_by { |_| _.id }
  end

end