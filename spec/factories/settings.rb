FactoryGirl.define do
  factory :setting do
    email { Faker::Internet.email }
  end
end
