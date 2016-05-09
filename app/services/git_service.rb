class GitService
  # ------------------------------------------------------------------
  # Class Methods
  # ------------------------------------------------------------------
  class << self
    # Get information by git
    # @param [Project] project
    def find_info(project)
      path = _prepare_dir(project)
      _clone_repository(project: project, path: path)
      json = _check_by_brakeman(path)

      {
          ruby_version: json.ruby_version,
          rails_version: json.rails_version,
          brakeman_json: json,
          error_message: nil
      }
    rescue => e
      { error_message: e.message }
    ensure
      FileUtils.rm_r(path)
    end

    private
    # ------------------------------------------------------------------
    # Private Class Methods
    # ------------------------------------------------------------------
    # Clone git repository to temporary folder
    def _clone_repository(project:, path:)
      if _has_ssh_key_setting?(project)
        _clone_with_setting_key(project: project, path: path)
      else
        _clone_with_system_key(project: project, path: path)
      end
    end

    def _clone_with_setting_key(project:, path:)
      ssh_key_path = Rails.root.join('tmp/ssh_key')
      begin
        File.open(ssh_key_path, 'w') { |file| file.write(project.setting_gitlab.try(:ssh_key)) }
        system("chmod 600 #{ssh_key_path.to_s.shellescape}")
        systemu("ssh-agent bash -c 'ssh-add #{ssh_key_path.to_s.shellescape}; git clone #{project.ssh_url_with_domain} #{path.to_s.shellescape}'")
      ensure
        FileUtils.rm_r(ssh_key_path)
      end
    end

    def _clone_with_system_key(project:, path:)
      systemu("git clone #{project.ssh_url_to_repo} #{path}")
    end

    def _has_ssh_key_setting?(project)
      project.setting_gitlab.try(:ssh_key).present?
    end

    # Prepare directory for cloning git repository
    def _prepare_dir(project)
      tmp_path = Rails.root.join("tmp/git_checkout/#{Rails.env}/#{project.id}/#{project.path_with_namespace}")
      tmp_path.mkpath unless tmp_path.exist?

      return tmp_path
    end

    # Security Check By Brakeman
    def _check_by_brakeman(path)
      result_json = [path, 'brakeman_result.json'].join('/')
      status, _stdout, stderr = systemu("bundle exec brakeman #{path.to_s.shellescape} -o #{result_json.to_s.shellescape}")
      raise StandardError.new(stderr) unless status.success? # Brakeman error

      BrakemanJson.new(JSON.parse(File.read(result_json)))
    end

  end
end