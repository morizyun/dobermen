namespace :db do
  desc 'Creates the database, loads the schema, and initializes with the seed data (use db:reset to also drop the database first)'
  task :setup => ['db:schema:load_if_ruby', 'db:structure:load_if_sql', :seed, :set_encrypt_salt]

  desc 'Set security salt to encrypt DB data'
  task set_encrypt_salt: :environment do
    file = Rails.root.join('config/application.yml').to_s

    File.open(file, 'r') do |f_in|
      buf = f_in.read.gsub(/^\s*SECURE_SALT:\s*\n?$/, "SECURE_SALT: #{SecureRandom.hex(64)}\n")
      File.open(file, 'w') { |_| _.write(buf) }
    end
  end
end