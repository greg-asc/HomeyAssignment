FactoryBot.define do
  factory :user do
    email { "user#{rand(1..999)}@homey.co.uk" }
    password { "VerySecurePassword9876" }
  end
end
