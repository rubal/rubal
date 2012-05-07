module RubalCore
  class Page
    # id страницы
    @id
    # путь к шаблону
    @erb_path
    # путь к необработанной странице
    @vhtml_path
    # адрес страницы в строке url
    @page_url
    # используемые плагины
    @used_plugins
    # заголовок страницы
    @page_title
    # массив html-подстановок
    @html_returned_by_plugins
    # страница-родитель
    @parent_page
    def initialize
      @page_url = "some_default_url"
      # массив имен плагинов, используемых на странице
      @used_plugins = Array.new
      @html_returned_by_plugins = Hash.new
    end
    def index
      page = Page.find(params[:id])
      render @erb_path
    end

    def self.new(id = 0, erb_path = "erb_path_by_default", vhtml_path = "vhtml_path_by_default", title = "New page title", parent = nil)
      @erb_path = erb_path
      @vhtml_path = vhtml_path
      @page_title = title
      @parent_page = parent
    end
  end
  p = Page.new
  # при создании страницы, записываем ее в бд в pid пишем id из бд.
end