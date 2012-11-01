# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invoice do
    project :factory => :project
    recipient "MyString"
    creator_name "MyString"
    creator_details "MyString"
    date "MyString"
    title "MyString"
    rate 30.99
    
    after_create {|inv| Factory(:time_entry, :invoice => inv)}
  end
end
