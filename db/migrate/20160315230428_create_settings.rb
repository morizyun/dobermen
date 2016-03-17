class CreateSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :settings do |t|
      t.string :email, null: false, comment: 'Notification to all project information'
      t.text :ssh_key, null: false, comment: 'SSH Key information'

      t.timestamps
    end
  end
end
