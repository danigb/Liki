require 'factory_girl'

FactoryGirl.define do
  factory :user, aliases: [:owner] do
    sequence(:name) {|n| "user#{n}" }
    email { "#{name}@email.com" }
  end

  factory :node do
    sequence(:title) {|n| "Title #{n}" }
    user
  end

  factory :group do
    sequence(:name) {|n| "group#{n}" }
  end
end
