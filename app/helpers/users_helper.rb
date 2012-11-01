module UsersHelper
  def avatar_tag(avatar_url_or_nil, size = 20)
    image_url = avatar_url_or_nil || "http://www.gravatar.com/avatar/00000000000000000000000000000000?s=140&d=mm"
    image_tag(image_url, :width => size, :height => size)
  end
  
  def user_avatar_tag(user, options = { :size => 24 })
    size = options.delete(:size)
    gravatar_token = user.gravatar_token.presence || Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "http://www.gravatar.com/avatar/#{gravatar_token}?s=#{size}&d=mm"
    image_tag(gravatar_url, { :width => size, :height => size }.merge(options))    
  end
  
end
