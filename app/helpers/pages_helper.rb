#encoding: utf-8
module PagesRoles
  def roles_hash
    return {
      :page => {"id" => 1, "name" => "Страница"},
      :template => {"id" => 2, "name" => "Шаблон"},
      :news_short => {"id" => 3, "name" => "Новость в списке"},
      :news_full => {"id" => 4, "name" => "Полная новость"},
      :chunk => {"id" => 5, "name" => "Чанк"}
    }
  end
  
  def get_role_by_id id
    roles_hash.each_pair {|role, vals| 
      return role if vals["id"] == id}
    return nil
  end
end

module PagesHelper
  #просто читает из файла7
  include PagesRoles
  def read_file path
    file = File.open(Rails.root.to_s + path)
    rethtml = ""
    file.each { |line| rethtml += line }
    return rethtml
  end
  #выдает двухэлементный массив - первый элемент это массив шаблонов для выведения в формате [имя_шаблона, id_шаблона]
  #второй - номер в этом массиве шаблона который стоит у переданной странице
  
  def get_templates
    templ_arr = [["Нет", ""]]
    templs = Page.where(:role => roles_hash[:template]["id"])
    templs.each { |t| templ_arr = templ_arr + [[t.name, t.id]] }
    return templ_arr
  end
  
  def get_template_uses t_id
    return Page.where(:template => t_id).size
  end
  
  #просто имя страницы по айдишнику
  def get_page_name id
    return "-" if id.nil?
    pg = Page.where(:id => id).first
    return pg.name
  end
  
  def get_roles_array
    ret = Array.new
    roles_hash.each {|n, r|
      ret+= [[r["name"], r["id"].to_s]]
      }
    return ret
  end
  
  #название типа
  def get_role_name role
    get_roles_array.each{|arr| return arr[0] if role.to_s == arr[1]}
    return "неизвестный тип"
  end
  
  def get_params_for_news news, page_rendering_to_url
    return {"news" => {
       "readmore_link" => "/"+page_rendering_to_url+"/" + news.id.to_s + ".html",
       "id" => news.id,
       "header" => news.header,
       "date" => news.date.strftime("%d/%m/%Y"),
       "full_text" => news.full_text.gsub(Regexp.new('\n'), "<br />"), 
       "short_text" => news.short_text.gsub(Regexp.new('\n'), "<br />")
       }}
  end

  #заменяет в передаваемом тексте processing_text значения из values_hash примерно так
  #если values_hash = {"param" => {"dude" => "hello, man!"}} то функция из
  # [[param:dude]]  сделает hello, man!
  def substitution processing_text, values_hash
    pr_text = processing_text.dup
    values_hash.each_pair{ |param_name, params_hash|
      if !params_hash.nil? && !params_hash.empty?
      #finder_regex = Regexp.new ("\\[\\[" + param_name + ":([a-z0-9_\\-]*)\\]\\]")
        finder_regex = Regexp.new("\\[\\[" + param_name + ":(([a-zA-Z0-9_\\-]*)(, ?([a-zA-Z0-9_\\-]+))*)\\]\\]")
        #Regexp.new("\\[\\[" + param_name + ":([a-zA-Z0-9_\\-]*)(, ?([a-zA-Z0-9_\\-]+))*)*\\]\\]")
        pr_text.gsub!(finder_regex) { |subst| params_hash[$1] }
      end
    }
    return pr_text
  end
  
  def substitution! processing_text, values_hash
    processing_text.replace! substitution processing_text, values_hash
  end
  
  def get_news_list_string page_rendering_to_url, trend = 'news', from = 0, limit = 1000, newsid = -1
      trend = 'news' if trend.nil?
      news = News.where(:trend_name => trend).limit(limit).offset(from).order('id desc')
      res = ""
      news_pattr = read_file NewsTrend.where(:key => trend).first.short_template.path
      news.each { |n| res += substitution( news_pattr, get_params_for_news(n, page_rendering_to_url)) }
      return res
  end
  
  def get_news_full_string page_rendering_to_url, newsid
      news_showing = News.find(newsid)
      news_pattr = read_file NewsTrend.where(:key => news_showing.trend_name).first.full_template.path
      res = ""
      res += substitution( news_pattr, get_params_for_news(news_showing, page_rendering_to_url))
      return res
  end
  
  def get_params_for_page page
    #обычные параметры страницы
    params = {"param" => {"title" => page.title}}

    unless page.additional_params.nil?
      params["param"].merge!(page.additional_params)
    end

    #смотрим есть ли на странице динамические элементы (напр. новости [[dynamic:news]] )
    dynamic_finder_regex = Regexp.new("\\[\\[dynamic:(([a-zA-Z0-9_\\-]*)(, ?([a-zA-Z0-9_\\-]+))*)\\]\\]")
                           #Regexp.new("\\[\\[dynamic:([a-zA-Z0-9_\\-]*)\\]\\]")
    dynamic_search_results = page.page_content.scan(dynamic_finder_regex)

    unless dynamic_search_results.empty?
      dyn_hash = Hash.new
      rr = ""
      dynamic_search_results.each{|a|
        if(a[1] == "news" && params["param"]["newsid"].nil?)
           dyn_hash.merge!({a[0] => get_news_list_string(page.url, a[3])} )
        elsif (a[1] == "news")
           dyn_hash.merge!({a[0] => get_news_full_string(page.url, params["param"]["newsid"]) } )
           
        elsif (a[0] == "admin_panel")
          #TODO : добавление админ панельки на страницу
        end
      } 

      params.merge!({"dynamic"=> dyn_hash})
    end

    chunk_finder_regex = Regexp.new("\\[\\[chunk:([a-zA-Z0-9_\\-]*)\\]\\]")
    chunk_search_results = page.page_content.scan(chunk_finder_regex)
    
    unless chunk_search_results.empty?
        chunk_hash = Hash.new
        rr = ""
        chunk_search_results.each{|a|
          found_chunk = Page.where(:role => roles_hash[:chunk]["id"], :subst_name => a[0]).first
          chunk_hash.merge!({a[0] => render_page(found_chunk, false) } ) unless found_chunk.nil?
        }
        params.merge!({"chunk"=> chunk_hash})
    end

    return params
  end
  
  def render_page page, return_safe_html = true, response_format = :html
    out_html = ""
    #окружающий html, вычисляется рекурсивно, мало ли, вдруг есть шаблоны в шаблонах
    out_html = render_page Page.find(page.template), false if (!page.template.nil? && response_format != :json)
    #берем код страницы из файлика
    page_html = read_file page.path
    page.page_content= page_html
    #проводим замены параметров на их значения
    page_html = substitution(page_html, get_params_for_page(page))
    #если шаблоны не были найдены, возвращаем уже код
    if(out_html.empty?)
      return (return_safe_html) ? page_html.html_safe : page_html
    else
      #а если были, то производим подстановку уже в них
      template_params = {"page" => {"content" => page_html, "title" => page.title}}
      ret_html = substitution(out_html, template_params)
      return (return_safe_html) ? ret_html.html_safe : ret_html 
    end
  end

  def render_page_to_json_hash page
    return :json => {:title => page.title, :name => page.name, :content => render_page( page, true, :json ) }.to_json
  end
end