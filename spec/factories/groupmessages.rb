FactoryBot.define do
  factory :groupmessage do
    content {Faker::Lorem.sentence}
    image {File.open("#{Rails.root}/app/assets/images/test_image.jpg")}
    user
    group
  end
end