require 'factory_girl'

FactoryGirl.define do
  factory :user, aliases: [:owner] do
    sequence(:name) {|n| "user#{n}" }
    email { "#{name}@email.com" }
  end

  factory :node do
    space 
    user
    sequence(:title) {|n| "Title #{n}" }
    body { "#{title} body" }
  end

  factory :space do
    user
    sequence(:name) {|n| "Space#{n}" }
    email { "#{name}@email.com" }
  end

  factory :photo do
    user
    space
  end
end
