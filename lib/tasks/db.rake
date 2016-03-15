namespace :db do
  desc 'Drop & Creates the database, loads all migration file, get gitlab, analyze project by brakeman'
  task :setup_by_gitlab => :environment do
    # rake db:drop
    puts `bundle exec rake db:drop`
    puts `bundle exec rake db:drop RAILS_ENV=test`

    # rake db:create
    puts `bundle exec rake db:create`

    # rake db:migrate
    puts `bundle exec rake db:migrate`
    puts `bundle exec rake db:migrate RAILS_ENV=test`

    # rake git:gitlab_all_repos
    puts `bundle exec rake git:gitlab_all_repos`

    # rake git:refresh_projects
    puts `bundle exec rake git:refresh_projects`
  end
end