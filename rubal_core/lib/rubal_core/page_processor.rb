require 'singleton'
require 'logger'
require  'rubal_core/plugin_manager'

module RubalCore
  class PageProcessor
    include Singleton

    def initialize
      @logger = Logger.new STDERR
      @i = 0
      @pid = 0
      #@html_replacements = []
      @placeholder_plugin_params_html_replacements = Hash.new
    end

    # regexp 4 placeholder
    ReplacerTemplate = /\[\[([a-zA-Z0-9_\-]*):([a-zA-Z0-9_\-]*)\]\]/
    # e.g.: [plugin_name:func_name]
    #"\\[\\[" + param_name + ":(([a-zA-Z0-9_\\-]*)(, ?([a-zA-Z0-9_\\-]+))*)\\]\\]"

    #если plugin_name и param не были использованы, запоминает их html в массив подстановок и возвращает его
    #иначе - возвращает их html
    def plugin_params_replacements_cache plugin_name, plugin_param
      # заменяем [[engine1:param1]] на строку в .erb "<%= render '/engine1/param1' %>"
      # ключ, по которому хранится строка для подстановки
      key = "<%= render '/#{plugin_name}/#{plugin_param}' %>"
      # строка подстановки
      value = "<%= render '/#{plugin_name}/#{plugin_param}' %>"
      # если такой плейсхолдер ранее не встречался,
      if @placeholder_plugin_params_html_replacements[key].nil?
        #@placeholder_plugin_params_html_replacements["#{plugin_name}=#{plugin_param}"] = PluginManager.instance.get_placeholder_value plugin_name, plugin_param
        @placeholder_plugin_params_html_replacements[key] = value
        # создаем связь плагинов и страниц, сохраняем запись в бд
        ppr = PagePluginRelation.new
        ppr.pid= @pid
        ppr.plugin_name= plugin_name
        ppr.plugin_params= plugin_param
        # путь к erb-вьюхе engine'а
        #ppr.plugin_returned_html= @placeholder_plugin_params_html_replacements["#{plugin_name}=#{plugin_param}"]
        ppr.plugin_returned_html= @placeholder_plugin_params_html_replacements[key]
        ppr.save
        #return @placeholder_plugin_params_html_replacements["<%= #{plugin_name}.#{plugin_param} %>"]
      end
      return @placeholder_plugin_params_html_replacements[key]
    end

    # Replace placeholders in text to values from values_hash
    # * text -- processing text
    # * values_hash -- list of param with values(see example)
    # replace "[[category:param]]", {"category" => {"param" => "value"}} # "[[category:param]]" will be replaced to "value"
    def replace text, values_hash
      raise TypeError unless (text.instance_of? String) && (values_hash.instance_of? Hash)
      result = text.gsub(ReplacerTemplate){
        # получаем имя плагина
        plugin_name = $1
        # и его метод
        plugin_param = $2
        plugin_params_replacements_cache(plugin_name, plugin_param)


        #p plugin_params_replacements_cache(plugin_name, plugin_param)
        #p '---'
        #запоминаем использованные плагины и их параметры в хэш вида:
        # @plugin_names_and_params["plugin_name=plugin_param"] => <some html string>
        #@plugin_names_and_params["#{plugin_name}=#{plugin_param}"] = PluginManager.instance.get_placeholder_value plugin_name, plugin_param
        #@plugin_names_and_params
        #@plugin_names_and_params += "#{plugin_name}=#{plugin_param};"
        #values_hash[$1][$2] unless values_hash[$1].nil?

        # заменяем каждый плейсхолдер на html-подстановку соответствующего плагина
        #@i+=1
        # @html_replacements[@i] = plugin_name.plugin_method
        #@html_replacements[@i] = PluginManager.instance.get_placeholder_value plugin_name, plugin_param
        #p "---#{@i}---"
        #p @html_replacements[@i]
        #p '--------'
        # html-подстановки плагинов
        #@html_replacements[@i] = "<% html[#{@i}] %>"
        #если такие plugin_name и param уже были использованы - возвращаем элемент массива, содержащий их html
        #"<% #{@html_replacements[@i]} %>"
      }
    end
    #
    def process page_path, target_path
      page_path = Rails.root.to_s + '/' + page_path
      target_path = Rails.root.to_s + '/' + target_path
      tmp_page = Thepage.find_last_by_erb_path(target_path)
      unless tmp_page.nil?
        @pid = tmp_page.id
      end
      text = File.read page_path
      # !обработка ВСЕХ плейсхолдеров для каждой страницы!
      values_hash = PluginManager.instance.placeholders
      result = replace text, values_hash
      File.open(target_path,"w"){|file|
        file.print result
      }

    #rescue Errno::ENOENT
    #  @logger.fatal "Cannot process file '#{page_path}'"
    #  raise
    #rescue
    #  @logger.fatal "Cannot target file '#{target_path}'"
    #  raise
    end
    def get_plugin_names_and_params
      @plugin_names_and_params
    end
  end
end
