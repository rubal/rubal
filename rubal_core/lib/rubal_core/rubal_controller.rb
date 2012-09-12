module RubalCore::RubalController
  require_relative "../rubal_core"

  def rubal_render page
    page_obj = nil
    page_obj = page if page.kind_of? Page
    page_obj ||= Page.find(page) if page.kind_of? Integer
    page_obj ||= Page.find_by_url(page) if page.kind_of? String

    fail "Unknown page type" if page_obj.nil?
    append_view_path(Rails.root.to_s)
    render page_obj.erb_path, :layout  => (page_obj.layout.nil?) ? false : ('../' + page_obj.layout.erb_path)
  end
end
