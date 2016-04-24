# Dobermen

Static analysis security tool for Ruby on Rails applications(Now making)

## Installation

1. Set SECRET_SALT for encrypting secret information in DB to config/application.yml.

2. Execute following command in terminal to setup DB in development/test:

```
bundle exec rake db:setup
```

3. Start server by `bundle exec rails server`

4. Open **[http://localhost:3000/setting_gitlabs](http://localhost:3000/setting_gitlabs)** and setting GitLab Information.

5. Execute following commands to get information of some repositories by GitLab:

```
bundle exec rake git:gitlab_all_repos

bundle exec rake git:refresh_projects
```

---

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
