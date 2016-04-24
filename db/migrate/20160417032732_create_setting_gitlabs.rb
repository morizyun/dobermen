class CreateSettingGitlabs < ActiveRecord::Migration[5.0]
  def change
    create_table :setting_gitlabs do |t|
      t.string  :base_url,      null: false, comment: 'Base url in your GitLab'
      t.text    :ssh_key,       null: false, comment: 'SSH Key information to get repository'
      t.string  :private_token, null: false, comment: 'Private token for accessing your GitLab API'

      t.timestamps
    end
    add_index :setting_gitlabs, :base_url, unique: true
  end
end
