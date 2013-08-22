FactoryGirl.define do
  factory :user do
    email "test@test.com"
    password "1234ABCD"
    password_confirmation "1234ABCD"
  end
end
