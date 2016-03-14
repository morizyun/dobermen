namespace :git do
  desc 'get information of visible gitlab repositories'
  task :gitlab_visible_repos => :environment do
    projects = GitlabService.all_projects(type: :user)
    projects.each { |p| Project.upsert!(p) }
  end

  desc 'get information of all gitlab repositories(need admin key)'
  task :gitlab_all_repos => :environment do
    projects = GitlabService.all_projects(type: :admin)
    projects.each { |p| Project.upsert!(p) }
  end

  desc 'get information of all git repositories'
  task :refresh_projects => :environment do
    Project.active_order.each do |p|
      info = GitService.find_info(p)
      p.update_attributes!(info)
    end
  end
end
