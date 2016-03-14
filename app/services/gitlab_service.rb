class GitlabService
  # ------------------------------------------------------------------
  # Constants
  # ------------------------------------------------------------------
  PER_PAGE = 10.freeze

  # ------------------------------------------------------------------
  # Public Class Methods
  # ------------------------------------------------------------------
  # Get all GitLab Projects
  # @return [Array<Gitlab::ObjectifiedHash>]
  def self.all_projects(type:)
    # TODO To enable change (Having model)
    Gitlab.endpoint = ENV['GITLAB_API_ENDPOINT']
    Gitlab.private_token = ENV['GITLAB_PRIVATE_TOKEN']

    if type == :admin
      _get_all_projects
    else
      _get_visible_projects
    end

  end

  private
  # ------------------------------------------------------------------
  # Private Class Methods
  # ------------------------------------------------------------------
  def self._get_all_projects
    # listing all user name
    user_names = Gitlab.users.map(&:username)

    # get all projects
    projects = user_names.map do |name|
      Gitlab.sudo = name
      Gitlab.projects(per_page: PER_PAGE).auto_paginate
    end.flatten.uniq { |_| _.id }

    # reset sudo
    Gitlab.sudo = nil

    return projects
  end

  def self._get_visible_projects
    Gitlab.projects(per_page: PER_PAGE).auto_paginate
  end

end