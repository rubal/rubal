class Page
  # id страницы
  @id
  # путь к шаблону
  @erb_path
  # путь к сырой странице
  @vhtml_path
  # адрес страницы в строке url
  @page_url
  # используемые плагины
  @used_plugins
  # массив html-подстановок
  @html_returned_by_plugins
  def initialize
    @used_plugins = Array.new
    @html_returned_by_plugins = Hash.new
  end
  def index
    page = Page.find(params[:id])

    render @erb_path
  end

end

#todo: таблица с pid страниц и плагинами m-t-m
class PagePluginUsingTable < ActiveRecord::Base
  #pid, plugin_name, plugin_params, plugin_returned_html
end
