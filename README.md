# Dobermen

Static analysis security tool for Ruby on Rails applications(Now making)

## Installation

1. Execute following command in terminal to setup DB in development/test:

```
bundle exec rake db:setup
```

2. Start server by `bundle exec rails server`

3. Open **[http://localhost:3000/setting_gitlabs](http://localhost:3000/setting_gitlabs)** and setting GitLab Information.

4. Execute following commands to get information of some repositories by GitLab:

```
bundle exec rake git:gitlab_all_repos

bundle exec rake git:refresh_projects
```

## Setup GitLab in your local (Optional)

If you want to setup GitLab in your local, please use following article which describes a procedure to setup GitLab with Docker:

**[Setup GitLab with Docker in local](http://blog.morizyun.com/posts/setup-gitlab-docker-in-local-mac)**

## Code Status

[![Build Status](https://travis-ci.org/morizyun/dobermen.svg?branch=features%2Fadd_travis_ci_settings)](https://travis-ci.org/morizyun/dobermen)

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
