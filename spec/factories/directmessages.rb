FactoryBot.define do
  factory :directmessage do
    content {Faker::Lorem.sentence}
    image {File.open("#{Rails.root}/app/assets/images/test_image.jpg")}
    user
    friend
  end
end