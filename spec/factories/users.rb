FactoryGirl.define do
  factory :user do
    first_name 'User First Name Test'
    last_name 'User Last Name Test'
    login 'User Login Test'
    email 'example@example.com'
    password 'please'
    password_confirmation 'please'

    confirmed_at Time.now

  end

  factory :admin, :parent => :user do
    role "admin"
    roles_mask 0
  end

  factory :basic, :parent => :user do
    role "basic"
    roles_mask 1
  end

  factory :medium, :parent => :user do
    role "medium"
    roles_mask 2
  end

  factory :premium, :parent => :user do
    role "premium"
    roles_mask 3
  end

end