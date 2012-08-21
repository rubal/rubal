module RubalCore
  require 'singleton'
  require "logger"
  #log = Logger.new(STDERR)

  # :title:Menu_Node
  # === Parameters
  #
  # ===
  # Содержит 2 класса:
  # * class RubalMenuNode
  # * class RubalMainMenu < RubalMenuNode
  # RubalMenuNode имеет члены:
  # * <tt>@hash_node</tt>     e.g. {:url => "/menu_url1", :name => "Menu_Node1" }
  # * <tt>@children_arr</tt>  e.g. [RubalMenuNode1, RubalMenuNode2]
  # * <tt>@parent</tt>        e.g. RubalMenuNode1
  class RubalMenuNode
    # ссылка на родителя нода
    @parent
    # название и урл нода
    @hash_node # = {}:pages => node1, :adminka => node2}
    # массив потомков нода
    @children_arr # = [child1, child2, ...]
    #@log
    attr_reader :hash_node, :children_arr
    # скрываем конструктор по умолчанию
    private_class_method :new

    # Создает пустой массив потомков children_arr и хэш по-умолчанию
    def initialize
      #@parent = nil  # Нод не имеет предков
      @children_arr = Array.new()
      @hash_node = Hash[:name => "default_name", :url => "/default/url"]
      # по умолчанию нод принадлежит базовому предку (супре предку)
      #super_parent = RubalMenuNode.new_node(Hash[:name => "super_parent", :url => "no_url"])
      #super_parent.set_parent= nil
      #@parent = super_parent

      #@log = Logger.new(STDOUT)
      #@log.level = Logger::WARN
    end

    # Свой конструктор для нодов
    # добавляет нод полностью (с массивом потомков)
    # и возвращает ссылку на созданный RubalMenuNode
    # e.g.: M = RubalMenuNode({:name => "my_name", :url => "my_url"}, [RubalMenuNode.new_node, RubalMenuNode.new_node], parent_node)

    def self.new_node(node_hash = {}, children = [], parent = nil)
      #используем приватный конструктор по умолчанию
      mn = new()
      #mn = RubalMenuNode.new
      if parent.class == RubalMenuNode
        self.set_parent= parent
      else
        #@log.warn("RubalMenuNode.new_node: parent must be RubalMenuNode class")
      end

      mn.add_hash= node_hash
      # проверка ключей
      if children.is_a?(Array) && children.all?{|child| child.class == RubalMenuNode}
        mn.add_children= children
      else
        #@log.warn("RubalMenuNode.new_node: children parameter must be Array of RubalMenuNode elements")
      end
      return mn
    end
    #alias_method :new_node, :add_node


    # Ноду устанавливается предок
    # Пример: some_node становится потомком нода A
    # some_node.set_parent= A
    def set_parent=(parent_node)
      # если родитель - это объект принадлежит классу МенюНод или унаследованн от класса МенюНод
      if parent_node.class == RubalMenuNode || parent_node.class.superclass == RubalMenuNode
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
        if child.class == RubalMenuNode
          child.set_parent = self
          new_arr.push(child)
        else
          @log.warn("set_children: not RubalMenuNode in array parameters")
        end
      }
      @children_arr = arr
    end

    # Добавляет после указанного нода новый нод
    # Параметр - нод, который будет добавлен
    # Добавляем после нода, от которого вызывается метод.
    # Пример: Node1.after!(Node2) добавляет после Node1 Node2
    def after!(node)
      # параметр должен быть класса RubalMenuNode
      if (!node.is_a?(RubalMenuNode))
        #log.error( "Not RubalMenuNode object was given" )
        p "Not RubalMenuNode object was given"
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
      if (!node.is_a?(RubalMenuNode))
        #log.error( "Not RubalMenuNode object was given" )
        p "Not RubalMenuNode object was given"
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
      if child.class == RubalMenuNode
        child.set_parent= self
        @children_arr.push(child)
      end
    end

    # добавляет массив потомков
    def add_children=( children )
      children.each{|child|
        # добавляем только элементы типа RubalMenuNode
        if (child.class == RubalMenuNode)
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

    ## Возвращает ноды поэлементно
    #def get_nodes
    #  @children_arr.each {|node|
    #    node
    #  }
    #end

    # собирает меню из элементов
    #def construct_menu
    #
    #end

    # Рекурсивный вывод всего меню в консоль
    # Parameters: нод, от которого вызывается функция и глубина рекурсии
    def rec_structure(menu_node, rec_dep)
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
  class RubalMainMenu < RubalMenuNode
    include Singleton
    def show_menu_structure
      @children_arr.each_index{|i|
        #p "Node ##{i}"
        @@rec_dep = 0
        rec_structure(@children_arr[i],0)
      }
    end
  end

  #a = RubalMenuNode.new_node({:name => "asdf", :url => "jljj"}, [], nil)
  ##p a = RubalMenuNode.my_new
  #
  ##log = Logger.new("../../log/development.log")
  #
  #mm = RubalMainMenu.instance
  #RubalMainMenu.instance.add_hash= {:name => "Main_Menu", :url => "Main_URL"}
  #
  ## получаем элементы меню в виде элементов массива хэшей
  #menu_arr = get_menu_array
  #menu_arr_size = menu_arr.size
  #
  ## создаем для каждого элемента массива НОВЫЙ! МенюНод
  #arr_nodes = Array.new(menu_arr_size) {|el| el = RubalMenuNode.new_node }
  #arr_nodes.each_index{|i|
  #  arr_nodes[i].add_hash= menu_arr[i]
  #}
  ##arr_nodes[1].add_child= RubalMenuNode.new_node
  #RubalMainMenu.instance.add_children= arr_nodes
  #
  ## добавление в главное меню, после 2го элемента, новый нод "before 2"
  #RubalMainMenu.instance.get_children[2].before!(RubalMenuNode.new_node({:name => "before 2", :url => "before 2"}))


  #new.del_node!
end