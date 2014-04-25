# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    gn_id 1
    name "MyString"
    address "MyString"
    city "MyString"
    state "MyString"
    holes 1
    par 1
    yards 1
    rating 1.5
    slope 1
  end
end
