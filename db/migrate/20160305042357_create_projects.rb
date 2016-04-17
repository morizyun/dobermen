class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.references  :setting_gitlab, index: true, comment: 'Association to setting GitLab'
      t.string      :path_with_namespace, null: false, comment: 'Repository path/namespace set'
      t.string      :web_url, null: false, comment: 'Repository web page url'
      t.string      :http_url_to_repo, null: false, comment: 'http url in repository'
      t.string      :ssh_url_to_repo, null: false, comment: 'SSH URL in repository'
      t.datetime    :last_activity_at, comment: 'user last activity timing'
      t.string      :ruby_version, comment: 'Ruby version(.ruby-version) in the project'
      t.string      :rails_version, comment: 'Rails version(Gemfile.lock) in the project'
      t.json        :brakeman_json, comment: 'Brakeman security check result in the project'
      t.text        :error_message, comment: 'Error Message in Process'
      t.string      :email, comment: 'Notification to project owner'

      t.timestamps
    end

    add_index :projects, :web_url, unique: true
  end
end
