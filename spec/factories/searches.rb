FactoryGirl.define do
  factory :search do
    required_terms "test"
    google         "google"
    twitter        "twitter"
  end
end
