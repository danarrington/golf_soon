# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tee_time do
    tee_time DateTime.tomorrow
    price 27.0
    players 4
    percent_off 50
  end
end
