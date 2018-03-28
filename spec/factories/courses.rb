FactoryBot.define do
  factory :course do
    currency_sign { 'USD' }
    rate { Faker::Number.decimal(5, 4) }
    uptodate { Faker::Date.forward(10) }
    end

    factory :invalid_course do
      currency_sign nil
    end
end
