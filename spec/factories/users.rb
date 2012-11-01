# encoding: UTF-8
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  sequence :email do |n|
    "email#{n}@timehub.net"
  end

  factory :user do
    username "timehub"
    email { Factory.next(:email) }
    name "Timehub Demo"
    site_url "http://timehub.net"
    access_token "my-github-access-token"
    github_uid "my-github-uid"

    factory :admin do
      admin true
    end

  end

end