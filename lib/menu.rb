# To change this template use File | Settings | File Templates.
require 'singleton'

require File.expand_path('../../config/init_menu', __FILE__)

## поиск в плагинах элементов меню
## возвращает массив из хэшей
##class NodesSearch
## получаем массив хэшей элементов меню
#def get_menu_array
#  # урл, название и потомки нода
#  arr = Array[
#      {:url => "/news", :name => "World News", :children => ["news_pages", "news_admin"] },
#      {:url => "/settings", :name => "Rubal Settings", :children => ["my_settings", "global_settings"] }
#  ]
#
#end
##end

# Элемент меню сам может быть меню.
class MenuNode
  # счетчик глубины рекурсии
  @@rec_dep = 0
  # строка вывода структуры меня
  @@rez_out = ''
  @hash_node # = {}:pages => node1, :adminka => node2}
  @children_arr # = [child1, child2, ...]

  def initialize
    @children_arr = Array.new()
    @hash_node = Hash[:name => "default_name", :url => "/default/url"]
  end

  # добавляет хэш ноду
  def add_hash=(hash)
    @hash_node = hash
  end

  # добавляет одного потомка
  def add_child=( child )
    @children_arr.push(child)
  end

  # добавляет массив потомков
  def add_children=( children )
    @children_arr = @children_arr + children
  end

  def del
    @hash_node.each_pair{|key, value|
    }
  end

  # Удаляет потомка по имени в хэше
  def del_child( name )

  end

  # Выводит содержимое нода
  def get_hash_node
    @hash_node
  end
  # Отображает меню из нодов
  def get_nodes
    @children_arr.each {|node|
      node
    }
  end

  # получает массив потомков
  def get_children
    @children_arr
  end

  # собирает меню из элементов
  def construct_menu

  end


  def rec_structure(menu_node)
    @@rec_dep+=1
    h = menu_node.get_hash_node
    if @@rec_dep > 1
      p @@rec_dep
      sum = '<br>'
      @@rec_dep.times{
        sum += '-'
      }
      @@rez_out +=  '|' + sum + "#{h[:name]}"
      #p  '|' + sum + "#{h[:url]}"
    else
      @@rez_out +=  "|#{h[:name]}"
      #p "|#{h[:url]}"
    end

    menu_node.get_children.each{|child|
      rec_structure(child)
    }
  end
end

# Главное меню
class MainMenu < MenuNode
  include Singleton
  def show_menu_structure
    @children_arr.each_index{|i|
      p "Node ##{i}"
      @@rec_dep = 0
      rec_structure(@children_arr[i])
    }
  end
  #def rec_structure(menu_node)
  #  @@rec_dep+=1
  #  h = menu_node.get_hash_node
  #  if @@rec_dep > 1
  #    p @@rec_dep
  #    sum = ''
  #    rezstr = @@rec_dep.times{
  #      sum += '-'
  #    }
  #    p  '|' + sum + "#{h[:name]}"
  #    p  '|' + sum + "#{h[:url]}"
  #  else
  #    p "|#{h[:name]}"
  #    p "|#{h[:url]}"
  #  end
  #
  #  menu_node.get_children.each{|child|
  #    rec_structure(child)
  #  }
  #end

end

# получаем элементы меню в виде элементов массива хэшей
menu_arr = get_menu_array
menu_arr_size = menu_arr.size

# создаем для каждого элемента массива НОВЫЙ! МенюНод
arr_nodes = Array.new(menu_arr_size) {|el| el = MenuNode.new }
arr_nodes.each_index{|i|
  arr_nodes[i].add_hash= menu_arr[i]
}

# добавление потомка для потомка
#ch = nodes[0].get_children
#ch[0].add_child= MenuNode.new

mm = MainMenu.instance
mm.add_hash={:name => "Main_Menu", :url => "Main_URL"}
mm.add_children= arr_nodes


