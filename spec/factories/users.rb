FactoryGirl.define do
  factory :user do
    name                  "User"
    email                 "user@example.com"
    password              "user123"
    password_confirmation "user123"
  end
end