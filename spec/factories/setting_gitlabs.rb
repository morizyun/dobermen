FactoryGirl.define do
  factory :setting_gitlab do
    base_url { "http://example.gitlab.com/#{Random.rand(10000)}/" }
    ssh_key { "ssh_key_#{Random.rand(100000)}" }
    private_token { "private_token_#{Random.rand(10000)}" }
  end
end
