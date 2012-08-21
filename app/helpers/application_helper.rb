#encoding: utf-8
require File.expand_path("rubal_core/lib/rubal_core", Rails.root.to_s)

module ApplicationHelper
  def get_page_content_for(page_id)
    page_content = PageContent.find_by_page_id(page_id)
    ((page_content.nil? or page_content.content.nil? or page_content.content.empty?) ? "<h1>Sorry, no content for this page</h1>" : page_content.content).html_safe
  end
end
