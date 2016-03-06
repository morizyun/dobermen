namespace :git do
  desc 'get information of all gitlab repositories'
  task :gitlab_repositories => :environment do
    projects = GitlabService.all_projects
    projects.each { |p| Project.upsert!(p) }
  end

  desc 'get information of all git repositories'
  task :gitlab_repositories => :environment do
    Project.active_order.each do |p|
      info = GitService.find_info(p)
      p.update_attributes!(info)
    end
  end
end
