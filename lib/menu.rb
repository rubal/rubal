module RubalCore
  require 'singleton'
  # Подключать меню не обязательно(!?)
  require File.expand_path('../../config/init_menu', __FILE__)
  require "logger"
  #log = Logger.new(STDERR)

  # :title:Menu_Node
  # === Parameters
  #
  # ===
  # Содержит 2 класса:
  # * class MenuNode
  # * class MainMenu < MenuNode
  # MenuNode имеет члены:
  # * <tt>@hash_node</tt>     e.g. {:url => "/menu_url1", :name => "Menu_Node1" }
  # * <tt>@children_arr</tt>  e.g. [MenuNode1, MenuNode2]
  # * <tt>@parent</tt>        e.g. MenuNode1
  class MenuNode
    # ссылка на родителя нода
    @parent
    # название и урл нода
    @hash_node # = {}:pages => node1, :adminka => node2}
    # массив потомков нода
    @children_arr # = [child1, child2, ...]
    #@log

    # скрываем конструктор по умолчанию
    private_class_method :new

    # Создает пустой массив потомков children_arr и хэш по-умолчанию
    def initialize
      #@parent = nil  # Нод не имеет предков
      @children_arr = Array.new()
      @hash_node = Hash[:name => "default_name", :url => "/default/url"]
      # по умолчанию нод принадлежит базовому предку (супре предку)
      #super_parent = MenuNode.new_node(Hash[:name => "super_parent", :url => "no_url"])
      #super_parent.set_parent= nil
      #@parent = super_parent

      #@log = Logger.new(STDOUT)
      #@log.level = Logger::WARN
    end

    # Свой конструктор для нодов
    # добавляет нод полностью (с массивом потомков)
    # и возвращает ссылку на созданный MenuNode
    # e.g.: M = MenuNode({:name => "my_name", :url => "my_url"}, [MenuNode.new_node, MenuNode.new_node], parent_node)

    def self.new_node(node_hash = {}, children = [], parent = nil)
      #используем приватный конструктор по умолчанию
      mn = new()
      #mn = MenuNode.new
      if parent.class == MenuNode
        self.set_parent= parent
      else
        #@log.warn("MenuNode.new_node: parent must be MenuNode class")
      end

      mn.add_hash= node_hash
      # проверка ключей
      if children.is_a?(Array) && children.all?{|child| child.class == MenuNode}
        mn.add_children= children
      else
        #@log.warn("MenuNode.new_node: children parameter must be Array of MenuNode elements")
      end
      return mn
    end
    #alias_method :new_node, :add_node


    # Ноду устанавливается предок
    # Пример: some_node становится потомком нода A
    # some_node.set_parent= A
    def set_parent=(parent_node)
      if parent_node.class == MenuNode
        @parent = parent_node
      end
    end

    # Получает ссылку на предка нода
    def get_parent
      @parent
    end

    # Задает массив потомков (существующий массив удаляется)
    def set_children= ( arr )
      # только если передан массив
      if arr.class != Array
        #@log.warn("To set_children= given not Array")
        return
      end
      new_arr = Array.new
      arr.each{|child|
        if child.class == MenuNode
          child.set_parent = self
          new_arr.push(child)
        else
          @log.warn("set_children: not MenuNode in array parameters")
        end
      }
      @children_arr = arr

      #newarr = arr.each{|child|
      #  #child != MenuNode
      #  if child.class == MenuNode
      #    child.set_parent= self
      #  end
      #  #else raise "Wrong type argument was given to set_children. MenuNode need."
      #
      #}
      #@children_arr = arr

      #newarr.each{|child|
      #  child.set_parent= self
      #}
      #@children_arr = newarr

    end

    # Добавляет после указанного нода новый нод
    # Параметр - нод, который будет добавлен
    # Добавляем после нода, от которого вызывается метод.
    # Пример: Node1.after!(Node2) добавляет после Node1 Node2
    def after!(node)
      # параметр должен быть класса MenuNode
      if (!node.is_a?(MenuNode))
        #log.error( "Not MenuNode object was given" )
        p "Not MenuNode object was given"
        return
      end
      # Получаем родителя текущего нода
      parent = self.get_parent
      # Если родитель == nil (нет родителя), то выходим ("добавить после" невозможно)
      if parent == nil
        return
      end
      parent_children = parent.get_children
      parent_children.each_index{|index|
        # если найден нод, после которого нужно вставлять
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
        #log.error( "Not MenuNode object was given" )
        p "Not MenuNode object was given"
        return
      end
      parent = self.get_parent
      # Если родитель == nil (нет родителя), то выходим ("добавить после" невозможно)
      if parent == nil
        return
      end
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
      if hash.class == Hash && hash.include?(:name) && hash.include?(:url)
        @hash_node = hash
      end
    end
    alias set_hash= add_hash=

    # добавляет одного потомка
    def add_child=( child )
      # для child назначается родитель-текущий нод
      if child.class == MenuNode
        child.set_parent= self
        @children_arr.push(child)
      end
    end

    # добавляет массив потомков
    def add_children=( children )
      children.each{|child|
        # добавляем только элемента типа MenuNode
        if (child.class == MenuNode)
          child.set_parent= self
          @children_arr += [child]
        end
      }
      #@children_arr += children
    end

    # to do: одна рекурсивная функция обхода меню,
    # To do: которой будет передаваться разный код для вывода, удаления и т.д.
    # yield{ ...some_code... }

    # Удаляет текущий нод и возвращает массив без этого нода
    # !Невозможно удалить нод, который не является чьим-либо потомком!
    def del_node!

      par = self.get_parent
      # нет потомков
      if par == nil
        return
      end
      chan = par.get_children
      chan.reject!{|child|
        self == child
      }
    end

    # Выводит содержимое нода
    def get_hash_node
      @hash_node
    end
    ## Возвращает ноды поэлементно
    #def get_nodes
    #  @children_arr.each {|node|
    #    node
    #  }
    #end

    # Получает массив потомков
    def get_children
      @children_arr
    end

    # собирает меню из элементов
    #def construct_menu
    #
    #end

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
        #p "Node ##{i}"
        @@rec_dep = 0
        rec_structure(@children_arr[i],0)
      }
    end
  end

  a = MenuNode.new_node({:name => "asdf", :url => "jljj"}, [], nil)
  #p a = MenuNode.my_new

  #log = Logger.new("../../log/development.log")
  # получаем элементы меню в виде элементов массива хэшей
  menu_arr = get_menu_array
  menu_arr_size = menu_arr.size

  # создаем для каждого элемента массива НОВЫЙ! МенюНод
  arr_nodes = Array.new(menu_arr_size) {|el| el = MenuNode.new_node }
  arr_nodes.each_index{|i|
    arr_nodes[i].add_hash= menu_arr[i]
  }

  # добавление потомка для потомка
  #ch = nodes[0].get_children
  #ch[0].add_child= MenuNode.new_node

  #arr_nodes[0].add_node({:name => "Main_Menu", :url => "Main_URL"})


  mm = MainMenu.instance

  mm.add_hash={:name => "Main_Menu", :url => "Main_URL"}
  #arr_nodes[1].add_child= MenuNode.new_node
  mm.add_children= arr_nodes


  arr_nodes[1].after!(MenuNode.new_node)
  arr_nodes[2].before!(MenuNode.new_node)
  new = MenuNode.new_node({:name => "superName", :url => "superUrl"})
  mm.add_child= new



  #new.del_node!

end