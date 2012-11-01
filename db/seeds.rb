# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# puts "Seeding user..."
# user_atts = { "access_token"    =>  "67dfd26636cafc8878f03cc7ca1a2b13067ef18e",
#               "admin"           =>  nil,
#               "github_uid"      =>  "9726",
#               "gravatar_token"  =>  "7e565a1681dc0137f43826aa840686af",
#               "name"            =>  "Andres Mejia",
#               "site_url"        =>  "http://andr.esmejia.com",
#               "username"        =>  "andmej"
#             }
# 
# user = User.find_or_create_by_email("andr@esmejia.com", user_atts)
# 
# 
# puts "Seeding project..."
# project = user.projects.create_from_github_repo(API::Repositories.new(user.access_token).load.first)
# 
# puts "Seeding invoice..."
# invoice = project.invoices.create
# 
# puts "Seeding time entries for invoice..."
# [15, 30, 45, 60].each do |minutes|
#   invoice.entries.create(:minutes => minutes, :description => "I werkd #{minutes} minutez")
# end
