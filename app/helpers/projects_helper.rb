module ProjectsHelper
  def populate_projects_link(text, options = {})
    reload_button_link_to text, populate_projects_path(:format => :js), {:remote => true, :method => :put}.merge(options)
  end
  
  def no_projects_on_github
    content_tag :div do
      content_tag(:h2, "It looks like you don't have any repos on Github yet.") +
      content_tag(:p, "You need to add some repos first so we can generate invoices based on them.")
    end
  end
end
