#module Menu
  require 'singleton'
  # Подключать меню не обязательно(!?)
  require File.expand_path('../../config/init_menu', __FILE__)

  # :title:Menu_Node
  # === Parameters
  #
  # ===
  # Содержит 2 класса:
  # * class MenuNode
  # * class MainMenu < MenuNode
  # MenuNode имеет члены:
  # * +hash_node+     e.g. {:url => "/menu_url1", :name => "Menu_Node1" }
  # * +children_arr+  e.g. [MenuNode1, MenuNode2]
  # * +parent+        e.g. MenuNode1
  class MenuNode
    # ссылка на родителя нода
    @parent
    # название и урл нода
    @hash_node # = {}:pages => node1, :adminka => node2}
    # массив потомков нода
    @children_arr # = [child1, child2, ...]

    # Создает массив потомков children_arr и хэш по-умолчанию
    def initialize
      #@parent = nil  # Нод не имеет предков
      @children_arr = Array.new()
      @hash_node = Hash[:name => "default_name", :url => "/default/url"]
    end

    # добавляет нод полностью (с массивом потомков)
    # и возвращает ссылку на созданный MenuNode
    def self.add_node(node_hash, children = [])
      mn = MenuNode.new
      mn.add_hash= node_hash
      if children.is_a?(Array)
        mn.add_children= children
      end
      return mn
    end

    # Ноду устанавливается предок
    # Пример: some_node становится потомком нода A
    # some_node.set_parent(A)
    def set_parent(parent_node)
      @parent = parent_node
    end

    # Получает ссылку на предка нода
    def get_parent
      @parent
    end

    # Задает массив потомков (существующий массив удаляется)
    def set_children= ( arr )
      @children_arr = arr
    end
    # Добавляет после указанного нода новый нод
    def after!(node)
      # параметр должен быть класса MenuNode
      if (!node.is_a?(MenuNode))
        p "Not MenuNode object was given"
        return
      end
      parent = self.get_parent
      parent_children = parent.get_children
      parent_children.each_index{|index|
        # если найден нод, после которого нужно вставлять
        p index
        if (parent_children[index] == self)
          # вырезает элементы массива до нода(включительно)), после которого будет вставка
          tmp_arr1 = parent_children.slice!(0,index+1)
          # добавляем нод
          tmp_arr1.push(node)
          # соединяем
          tmp_arr2 = tmp_arr1 + parent_children
          # изменяем массив потомков на новый
          parent.set_children= (tmp_arr2)
          return tmp_arr2
        end
      }
    end
    # добавляет нод перед текущим
    def before!(node)
      if (!node.is_a?(MenuNode))
        p "Not MenuNode object was given"
        return
      end
      parent = self.get_parent
      parent_children = parent.get_children
      new_parent_children = parent_children.each_index{|index|
        # если найден нод, после которого нужно вставлять
        if (parent_children[index] == self)
          # вырезает элементы массива до нода(включительно)), после которого будет вставка
          tmp_arr1 = parent_children.slice!(0,index)
          # добавляем нод
          tmp_arr1.push(node)
          # соединяем
          tmp_arr2 = tmp_arr1 + parent_children
          # изменяем массив потомков на новый
          parent.set_children= (tmp_arr2)
          return tmp_arr2
        end
      }
    end
    
    # добавляет хэш ноду
    def add_hash=(hash)
      @hash_node = hash
    end

    # добавляет одного потомка
    def add_child=( child )
      # для child назначается родитель-текущий нод
      child.set_parent(self)
      @children_arr.push(child)
    end

    # добавляет массив потомков
    def add_children=( children )
      children.each{|child|
        child.set_parent(self)
      }
      @children_arr = @children_arr + children
    end

    # todo: одна рекурсивная функция обхода меню,
    # todo: которой будет передаваться разный код для вывода, удаления и т.д.
    # yield{ ...some_code... }

    # Удаляет текущий нод и возвращает массив без этого нода
    def del_node! #( node )
      par = self.get_parent
      chan = par.get_children
      chan.reject!{|child|
        self == child
      }
    end

    # Выводит содержимое нода
    def get_hash_node
      @hash_node
    end
    # Возвращает ноды поэлементно
    def get_nodes
      @children_arr.each {|node|
        node
      }
    end

    # Получает массив потомков
    def get_children
      @children_arr
    end

    # собирает меню из элементов
    def construct_menu

    end

    # Рекурсивный вывод всего меню в консоль
    # Parameters: нод, от которого вызывается функция и глубина рекурсии
    def rec_structure(menu_node,rec_dep)
      h = menu_node.get_hash_node
      sum = ""
      rec_dep.times{
        sum += "--"
      }

      children = menu_node.get_children
      # Если есть потомки, обходим их
      if children.any?
        children.each{|child|
          rec_structure(child,rec_dep += 1)
        }
      end
      # Здесь элемент может быть удален, выведен и т.д. в зависимости от переданного блока
      yield
    end
  end

  # Главное меню
  class MainMenu < MenuNode
    include Singleton
    def show_menu_structure
      @children_arr.each_index{|i|
        p "Node ##{i}"
        @@rec_dep = 0
        rec_structure(@children_arr[i],0)
      }
    end
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

  #arr_nodes[0].add_node({:name => "Main_Menu", :url => "Main_URL"})


  mm = MainMenu.instance
  mm.add_hash={:name => "Main_Menu", :url => "Main_URL"}
  #arr_nodes[1].add_child= MenuNode.new
  mm.add_children= arr_nodes


  arr_nodes[1].after!(MenuNode.new)
  arr_nodes[2].before!(MenuNode.new)
  new = MenuNode.add_node({:name => "superName", :url => "superUrl"})
  mm.add_child= new

  new.del_node!

#end