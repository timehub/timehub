# encoding: UTF-8
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  sequence :commit_sha do |n|
    rand(36 ** 40).to_s(36)
  end

  factory :commit do
    project :factory => :project
    committed_at "2011-08-13 13:31:59"
    message "Commit supper specific message"
    sha { Factory.next(:commit_sha) }
    author_username "andmej"
  end

end