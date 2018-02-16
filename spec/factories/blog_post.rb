FactoryBot.define do
  factory :blog_post do
    title { Faker::Lorem.word }
    content { Faker::Lorem.paragraph }
    view_rights "Admin"
    user
  end
end
