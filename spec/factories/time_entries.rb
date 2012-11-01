# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :time_entry do
    invoice :factory => :invoice
    description "My super hard task"
    minutes 125
  end
end
