class Page < ActiveRecord::Base

  validates_presence_of :title, :position

  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::UrlHelper

  def html_body
    auto_link(self.body)
  end
  
end
