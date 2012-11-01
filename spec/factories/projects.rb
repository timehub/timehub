# encoding: UTF-8
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :repo_name do |n|
    "Repository #{n}"
  end

  factory :project do |project|
    project.name { Factory.next(:repo_name) }
    project.description "A timehub demo project"
    project.html_url "http://github.com/timehub/issues"
    project.api_url "https://api.github.com/repos/timehub/issues"
    project.owner_username "timehub"
    project.owner_avatar_url ""
    project.rate 29.99
    project.user { |p| p.association(:user) }

    factory :private_project do
      project.private true
    end
  end
end