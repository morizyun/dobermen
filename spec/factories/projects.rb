FactoryGirl.define do
  factory :project do
    path_with_namespace { "test/rails-sample#{Random.rand(10000)}" }
    web_url { "https://example.com/root/rails-sample#{Random.rand(10000)}" }
    ssh_url_to_repo { "git@example.com:test_user/rails-sample#{Random.rand(10000)}.git" }
    http_url_to_repo { "https://example.com/test_user/rails-sample#{Random.rand(10000)}.git" }
    last_activity_at { Random.rand(100).days.ago }
    ruby_version { "2.#{Random.rand(10)}.#{Random.rand(10)}" }
    rails_version { "5.#{Random.rand(10)}.#{Random.rand(10)}" }
    email { Faker::Internet.email }
  end
end
