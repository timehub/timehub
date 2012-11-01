Factory.define :activity do |a|
  a.description "Finished the deal"
  a.minutes 60
  a.from "js"
  a.association :project
end
