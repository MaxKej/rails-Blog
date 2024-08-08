FactoryBot.define do
  factory :comment do
    content { "This is a comment." }
    association :post
    association :user # Opcjonalne jeśli komentarz nie wymaga użytkownika
  end
end
