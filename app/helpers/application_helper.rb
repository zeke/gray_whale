# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def page_title
    "GrayWhale"
  end

  # e.g. http://localhost:3000, or https://example.com
  def base_url
    "#{request.protocol}#{request.host_with_port}"
  end
  
end
