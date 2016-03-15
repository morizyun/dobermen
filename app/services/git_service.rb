class GitService
  # ------------------------------------------------------------------
  # Public Class Methods
  # ------------------------------------------------------------------
  # Get information by git
  # @param [Project] project
  def self.find_info(project)
    path = _prepare_dir(project)
    _clone_repository(project: project, path: path)
    json = _check_by_brakeman(path)

    {
        ruby_version: json.ruby_version,
        rails_version: json.rails_version,
        brakeman_json: json
    }
  rescue => e
    puts "Error: #{e.message} [GitService.find_info]"
    { error_message: e.message }
  ensure
    _remove_dir(path)
  end

  private
  # ------------------------------------------------------------------
  # Private Class Methods
  # ------------------------------------------------------------------
  # Clone git repository to temporary folder
  def self._clone_repository(project:, path:)
    # TODO To enable change (Having model)
    # NOTE: using ssh key for each user => http://goo.gl/ndFEm
    systemu("git clone #{project.ssh_url_to_repo} #{path}")
  end

  # Prepare directory for cloning git repository
  def self._prepare_dir(project)
    tmp_path = Rails.root.join("tmp/git_checkout/#{Rails.env}/#{project.path_with_namespace}#{Random.rand(10000)}").to_s
    FileUtils.mkdir_p(tmp_path) unless FileTest.exist?(tmp_path)

    return tmp_path
  end

  # Remove directory for clone git repository
  def self._remove_dir(path)
    FileUtils.rm_r(path)
  end

  # Security Check By Brakeman
  def self._check_by_brakeman(path)
    result_json = [path, 'brakeman_result.json'].join('/')
    status, stdout, stderr = systemu("bundle exec brakeman #{path} -o #{result_json}")
    raise StandardError.new(stderr) unless status.success? # Brakeman error

    BrakemanJson.new(JSON.parse(File.read(result_json)))
  end

end