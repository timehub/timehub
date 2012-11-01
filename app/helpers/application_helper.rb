module ApplicationHelper
  # http://railscasts.com/episodes/197-nested-model-form-part-2
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :builder => builder)
    end

    function = raw("addFields(this, '#{association}', '#{escape_javascript(fields)}')")
    link_to_function(name, function, :class => "button icon add")
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + remove_button_link_to(name, "#", :class => "remove_nested")
  end
  
  def clear
    '<div class="clear"></div>'.html_safe
  end
  
  def format_minutes(minutes)
    return "" if minutes.blank?
    hours = minutes / 60
    fmin = "%02d" % (minutes % 60).to_s
    "#{hours}:#{fmin}"
  end
  
  def blog_path
    "http://blog.timehub.net"
  end
  alias :blog_url :blog_path
end
