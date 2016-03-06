class GitService
  # ------------------------------------------------------------------
  # Public Class Methods
  # ------------------------------------------------------------------
  # Get information by git
  # @param [Project] project
  def self.find_info(project)
    path = _prepare_dir(project)
    _clone_repository(project: project, path: path)

    {
        ruby_version: _get_ruby_version(path),
        rails_version: _get_rails_version(path),
        brakeman_json: _check_by_brakeman(path)
    }
  ensure
    _remove_dir(path)
  end

  private
  # ------------------------------------------------------------------
  # Private Class Methods
  # ------------------------------------------------------------------
  # Clone git repository to temporary folder
  def self._clone_repository(project:, path:)
    system("git clone #{project.ssh_url_to_repo} #{path}")
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

  # Get Ruby Version
  def self._get_ruby_version(path)
    rv_path = [path, '.ruby-version'].join('/')
    text = File.read(rv_path).to_s rescue ''
    text =~ /([0-9\.]{2,})/ ? $1 : text
  end

  # Get Rails Version
  def self._get_rails_version(path)
    gem_lock_path = [path, 'Gemfile.lock'].join('/')
    text = File.read(gem_lock_path).to_s rescue ''
    text =~ /\s+rails\s\((.*)\)/ ? $1 : nil
  end

  # Security Check By Brakeman
  def self._check_by_brakeman(path)
    result_json = [path, 'brakeman_result.json'].join('/')
    system("bundle exec brakeman #{path} -o #{result_json}")
    JSON.parse(File.read(result_json))
  end

end