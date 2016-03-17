FactoryGirl.define do
  factory :setting do
    email { Faker::Internet.email }
    ssh_key { Faker::Lorem.sentences.join('').gsub(/\s/, '') }
  end
end
