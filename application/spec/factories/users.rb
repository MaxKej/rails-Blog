FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" } # Zapewnia unikalny adres email
    password { "password123" }
    password_confirmation { "password123" }

    trait :admin do
      after(:create) do |user|
        user.add_role(:admin)
      end
    end

    trait :normal do
      after(:create) do |user|
        user.add_role(:normal)
      end
    end
  end
end
