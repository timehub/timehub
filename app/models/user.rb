class User < ActiveRecord::Base
  has_many :projects
  has_many :invoices, :through => :projects

  make_permalink :username
  
  attr_protected :admin
  
  def to_param
    permalink
  end
  

  def self.create_from_omniauth(omniauth)
    User.new.tap do |user|
      user.assign_attributes_from_omniauth(omniauth)
      user.save!
    end
  end

  def self.find_and_update_from_omniauth(omniauth)
    if user = User.find_by_github_uid(omniauth["uid"])
      user.assign_attributes_from_omniauth(omniauth)
      user.save!
    end
    user
  end
  
  def name_or_username
    name.presence || username
  end
  
  def to_s
    name_or_username
  end

  def assign_attributes_from_omniauth(omniauth)
    self.access_token = omniauth["credentials"]["token"]
    self.github_uid = omniauth["uid"]
    self.username = omniauth["user_info"]["nickname"]
    self.email = omniauth["user_info"]["email"]
    self.name = omniauth["user_info"]["name"]
    self.site_url = omniauth["user_info"]["urls"]["Blog"] if omniauth["user_info"]["urls"]
    self.gravatar_token = omniauth["extra"]["user_hash"]["gravatar_id"] if omniauth["extra"] && omniauth["extra"]["user_hash"]
  end

end
