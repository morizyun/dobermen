class GitlabService
  # ------------------------------------------------------------------
  # Constants
  # ------------------------------------------------------------------
  PER_PAGE = 10

  # ------------------------------------------------------------------
  # Class Methods
  # ------------------------------------------------------------------
  class << self
    # Get all projects on GitLab by using admin role
    def get_all_projects(setting)
      _set_connect_settings(setting)

      # listing all user name
      user_names = Gitlab.users.map(&:username)

      # get all projects
      projects = user_names.map do |name|
        Gitlab.sudo = name
        Gitlab.projects(per_page: PER_PAGE).auto_paginate
      end.flatten.uniq { |name| name.id }

      # reset sudo
      Gitlab.sudo = nil

      return projects
    end

    # Get all visible projects on GitLab
    def get_visible_projects(setting)
      _set_connect_settings(setting)

      Gitlab.projects(per_page: PER_PAGE).auto_paginate
    end

    private

      # Set settings
      def _set_connect_settings(setting)
        Gitlab.endpoint = setting.endpoint
        Gitlab.private_token = setting.private_token
      end
  end
end