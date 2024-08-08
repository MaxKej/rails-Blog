FactoryBot.define do
  factory :post do
    title { "Sample Title" }
    content { "Sample Content" }
    association :user
  end
end
