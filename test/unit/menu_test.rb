#require Rails.root.to_s + 'lib/menu.rb'
require File.expand_path('../../../lib/menu', __FILE__)
require "test/unit"
class MenuTest < Test::Unit::TestCase

  def test_good
    test1 = MenuNode.add_node
    # потомки должны быть массивом
    assert( test1.get_children.class == Array, 'MenuNode children is not Array' )
    # массив потомков по умолчанию пуст
    assert(test1.get_children == [], 'Children not empty by default')
    # хэш по умолчанию для созданного нода -- Hash[:name => "default_name", :url => "/default/url"]
    assert( test1.get_hash_node == Hash[:name => "default_name", :url => "/default/url"], 'Initialized with not default hash' )
    # родитель по умолчанию == nil
    assert(test1.get_parent == nil, 'parent not nil by default')

    # тестируем add_node с 1 параметром -- хэш
    test2 = MenuNode.add_node( Hash[:name => "default_name", :url => "/default/url"])
    assert(test2.class == MenuNode.add_node.class, 'add_node returns not MenuNode')
    assert(test2.get_hash_node == Hash[:name => "default_name", :url => "/default/url"] , 'add_node returns wrong hash' )
    #assert(test2.get_children == [], 'add_node returns not empty array')

    # ввод неверных параметров
    test2 = MenuNode.add_node("asdf", 1234, Array)
    assert((test2.get_children == []) && (test2.get_hash_node == Hash[:name => "default_name", :url => "/default/url"]),'')


    # тестируем add_node с параметрами хэш и массив потомков
    test3 = MenuNode.add_node( Hash[:name => "name", :url => "url"], [MenuNode.add_node, MenuNode.add_node, MenuNode.add_node])
    #assert(test3.get_children == [MenuNode.add_node], 'add_node returns not empty array')
    chan = test3.get_children
    chan.each{|child|
      # потомки должны быть класса MenuNode
      assert(child.class == MenuNode , 'child is not MenuNode')
      # иметь в качестве своего родителя нод test3
      assert(child.get_parent == test3, 'child has wrong parent')
      # set_parent устанавливает нового родителя
      child.set_parent= test2
      assert(child.get_parent == test2, 'set_parent sets wrong parent ')
    }

    test4 = MenuNode.add_node
    # set_children устанавливает ноду указанный массив потомков
    some_arr = [MenuNode.add_node, MenuNode.add_node, MenuNode.add_node, MenuNode.add_node]
    test4.set_children= some_arr

    test4.get_children.each{|child|
      # у всех потомков предком является test4
      assert(child.get_parent == test4, 'set_children sets wrong parents')
    }
    # get_children должен вернуть тот же массив, что был передан в set_children

    assert(test4.get_children == some_arr, 'set_children sets wrong array of children')

    # проверка на вставку не MenuNode
    good_arr = [MenuNode.add_node, MenuNode.add_node]
    test4.set_children= good_arr + [ 'asdf', 1234, String, {:oops => "oops"}]
    #p test4.get_children
    #p good_arr
    #assert(test4.get_children == good_arr)

    # Проверка after!
    test5 = MenuNode.add_node
    #test5.set_children= [node1 = MenuNode.add_node, node2 = MenuNode.add_node, node3 = MenuNode.add_node, node4 = MenuNode.add_node]
    node1 = MenuNode.add_node
    test5.set_children= [node1]
    node2 = MenuNode.add_node({:name => 'special_name2', :url => 'special_url2'})
    node1.after!(node2)
    # есть среди потомков вставленный нод "one"
    inserted = test5.get_children.any?{|any_child|
      any_child == node2
    }
    assert(inserted == true, 'after! doesn\'t insert node')
    # вставлен именно после node1
    chan = test5.get_children
    chan.each_index{|index|
      # находим нод, после которого производится вставка
      if node1 == chan[index]
        # следующий за ним должен быть вставляемый нод node2
        assert(node2 == chan[index+1], 'after! inserts node in wrong place')
      end
    }
    # вставлен в единственном экземпляре
    my_arr = chan.find_all{|child|
      child == node2
    }
    assert(my_arr == [node2], 'after! inserts node not only 1 time')

    # Проверка before!
    test6 = MenuNode.add_node
    node2 = MenuNode.add_node
    test6.set_children= [node2]
    node1 = MenuNode.add_node({:name => 'special_name1', :url => 'special_url1'})
    node2.before!(node1)
    # есть среди потомков вставленный нод "node1"
    inserted = test6.get_children.any?{|any_child|
      any_child == node1
    }
    assert(inserted == true, 'before! doesn\'t insert node')
    # вставлен именно до node2
    chan = test6.get_children
    chan.each_index{|index|
      # находим нод, до которого производится вставка
      if node2 == chan[index]
        # перед за ним должен быть вставляемый нод node1
        assert(node1 == chan[index-1], 'before! inserts node in wrong place')
      end
    }
    # вставлен в единственном экземпляре
    my_arr = chan.find_all{|child|
      child == node1
    }
    assert(my_arr == [node1], 'before! inserts node not only 1 time')

    # тест добавления хэша
    test7 = MenuNode.add_node
    test7.add_hash= {:name => 'special_name', :url => 'special_url'}
    assert(test7.get_hash_node == {:name => 'special_name', :url => 'special_url'}, 'add_hash added wrong hash')


    test8 = MenuNode.add_node
    ch = MenuNode.add_node({:name => 'child', :url => 'child_url'})
    test8.add_child= ch
    # add_child устанавливает верного предка
    assert(ch.get_parent == test8, 'add_child: relation parent-child is wrong')
    # потомок добавлен в массив потомков и является единственным
    my_arr = test8.get_children.find_all{|child|
      child == ch
    }
    assert(my_arr == [ch], 'add_child: Parent has not child')

    test9 = MenuNode.add_node
    some_arr = [MenuNode.add_node, MenuNode.add_node, MenuNode.add_node, MenuNode.add_node, MenuNode.add_node, MenuNode.add_node]
    test9.add_children= some_arr
    # проверка на добавление массива потомков
    assert(test9.get_children == some_arr,'get_children must return the same result as add_children')

    test10 = MenuNode.add_node
    node1 = MenuNode.add_node
    some_arr = [node1, "asf", MenuNode, 1234]
    test10.add_children= some_arr
    assert(test10.get_children == [node1],'get_children must return the same result as add_children')





  end
  ## Called before every test method runs. Can be used
  ## to set up fixture information.
  #def setup
  #  # Do nothing
  #end
  #
  ## Called after every test method runs. Can be used to tear
  ## down fixture information.
  #
  #def teardown
  #  # Do nothing
  #end
  #
  ## Fake test
  #def test_fail
  #
  #  # To change this template use File | Settings | File Templates.
  #  fail("Not implemented")
  #end
end