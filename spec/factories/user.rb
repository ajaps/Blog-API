FactoryGirl.define do
  factory :user do
    sequence(:user_id) { |n| "YTHBERLO #{n}" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    gender 'Male'
    role 'Admin'
  end
end
