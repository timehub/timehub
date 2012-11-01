module CommitsHelper
  def status_bulb_for(commit)
    if commit.invoiced?
      image_url, message = "red_bulb.png", "This commit has already been invoiced."
    else
      image_url, message = "green_bulb.png", "This commit hasn't been invoiced yet!"
    end
    link_to image_tag(image_url), "#", :title => message, :class => "tipsied"
  end
end
