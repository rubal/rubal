require 'test_helper'
require 'rubal_core/menu'
#require Rails.root.to_s + '/lib/menu.rb'

include RubalCore

#require File.expand_path('../../../lib/menu', __FILE__)
#require "test/unit"
# Запуск тестов (набирать из корня проекта): ruby -Itest test/unit/menu_test.rb

class MenuTest < ActiveSupport::TestCase
  #test "ttt" do
  #  #assert(1==1, "noooo")
  #  assert false, "test"
  #end



  test "new node 1" do
    test_node = MenuNode.new_node
    # потомки должны быть массивом
    assert( test_node.get_children.class == Array, 'MenuNode children must be an Array' )
    # массив потомков по умолчанию пуст
    assert(test_node.get_children == [], 'Children must be empty by default')
    # хэш по умолчанию для созданного нода -- Hash[:name => "default_name", :url => "/default/url"]
    assert( test_node.get_hash_node == Hash[:name => "default_name", :url => "/default/url"], 'Initialized with not default hash' )
    # родитель по умолчанию == nil
    assert(test_node.get_parent == nil, 'parent must be nil by default')
  end

  test "new node 2" do
    # тестируем add_node с 1 параметром -- хэш
    test_hash = Hash[:name => "test_name", :url => "/test/url"]
    test_node = MenuNode.new_node( test_hash )
    assert(test_node.class == MenuNode.new_node.class, 'add_node must returns  MenuNode')
    assert(test_node.get_hash_node == test_hash , 'add_node returns wrong hash' )
  end

  test "new node with wrong types params" do
    # ввод неверных параметров
    test_node = MenuNode.new_node("asdf", 1234, Array)
    assert((test_node.get_children == []) && (test_node.get_hash_node == Hash[:name => "default_name", :url => "/default/url"]),'if someone create MenuNode with wrong type parameters it will have create MenuNode with default parameters')
  end
  test "add node with hash and children array params" do
    # тестируем add_node с параметрами хэш и массив потомков
    nodes_arr = [MenuNode.new_node, MenuNode.new_node, MenuNode.new_node]
    test_node = MenuNode.new_node( Hash[:name => "name", :url => "url"], nodes_arr)
    assert(test_node.get_children == nodes_arr, 'add_node returns not empty array')
    chan = test_node.get_children
    chan.each{|child|
      # потомки должны быть класса MenuNode
      assert(child.class == MenuNode , 'child is not MenuNode')
      # иметь в качестве своего родителя нод test_node
      assert(child.get_parent == test_node, 'child has wrong parent')
      # set_parent устанавливает нового родителя
      child.set_parent= test_node
      assert(child.get_parent == test_node, 'set_parent sets wrong parent ')
    }
  end
  test "test set_children" do
    test_node = MenuNode.new_node
    # set_children устанавливает ноду указанный массив потомков
    some_arr = [MenuNode.new_node, MenuNode.new_node, MenuNode.new_node, MenuNode.new_node]
    test_node.set_children= some_arr

    test_node.get_children.each{|child|
      # у всех потомков предком является test_node
      assert(child.get_parent == test_node, 'set_children sets wrong parents')
    }
    # get_children должен вернуть тот же массив, что был передан в set_children
    assert(test_node.get_children == some_arr, 'set_children sets wrong array of children')

  end
  test "children array has only MenuNode types even if given not MenuNode" do
    # проверка на вставку не MenuNode
    test_node = MenuNode.new_node
    good_arr = [MenuNode.new_node, MenuNode.new_node]
    bad_arr =  [ 'asdf', 1234, String, {:oops => "oops"}]
    test_node.set_children= good_arr
    assert(test_node.get_children == good_arr, "get_children get not same result as set_children sets")
  end
  test "insert after node with after! method" do
    # Проверка after!
    test_node = MenuNode.new_node
    #test_node.set_children= [node1 = MenuNode.new_node, node2 = MenuNode.new_node, node3 = MenuNode.new_node, node4 = MenuNode.new_node]
    node1 = MenuNode.new_node
    test_node.set_children= [node1]
    node2 = MenuNode.new_node({:name => 'special_name2', :url => 'special_url2'})
    # вставляем после node1 node2
    node1.after!(node2)
    # есть среди потомков вставленный нод "one"
    inserted = test_node.get_children.find_all{|any_child|
      any_child == node2
    }
    assert(inserted == [node2], 'after! doesn\'t insert node')
    # вставлен именно после node1
    chan = test_node.get_children
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

  end

  test "same test for before! method" do
    # Проверка before!
    test_node = MenuNode.new_node
    node2 = MenuNode.new_node
    test_node.set_children= [node2]
    node1 = MenuNode.new_node({:name => 'special_name1', :url => 'special_url1'})
    node2.before!(node1)
    # есть среди потомков вставленный нод "node1"
    inserted = test_node.get_children.find_all{|any_child|
      any_child == node1
    }
    assert(inserted == [node1], 'before! doesn\'t insert node')
    # вставлен именно до node2
    chan = test_node.get_children
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
  end
  test "hash addition" do
    # тест добавления хэша
    test_node = MenuNode.new_node
    test_node.set_hash= {:name => 'special_name', :url => 'special_url'}
    assert(test_node.get_hash_node == {:name => 'special_name', :url => 'special_url'}, 'add_hash added wrong hash')

    test_node = MenuNode.new_node
    ch = MenuNode.new_node({:name => 'child', :url => 'child_url'})
    test_node.add_child= ch
    # add_child устанавливает верного предка
    assert(ch.get_parent == test_node, 'add_child: relation parent-child is wrong')
    # потомок добавлен в массив потомков и является единственным
    my_arr = test_node.get_children.find_all{|child|
      child == ch
    }
    assert(my_arr == [ch], 'add_child: Parent has not child')

    # добавление хэша без :name и :url
    some_hash = {:name => "test_name", :url => "test_url"}
    test_node.set_hash= some_hash
    test_node.set_hash= {:asdf => "asdf", :djfkg => "sdf"}
    assert( test_node.get_hash_node == some_hash, "hash without :name and :url was set" )

    # добавление хэша с мусором и :name и :url
    some_hash = {:name => "test_name_100500", :url => "test_url_100500"}
    test_node.set_hash= some_hash
    hash_with_trash = {:asdf => "asdf", :djfkg => "sdf", :name => 'title', :url => 'google.ru'}
    test_node.set_hash= hash_with_trash
    assert( test_node.get_hash_node != some_hash, "set_hash can/'t set hash with trash and :name :url params'" )
    assert( test_node.get_hash_node == hash_with_trash, "set_hash set wrong hash")
  end
  test "get_children must return the same result as add_children set" do
    test_node = MenuNode.new_node
    some_arr = [MenuNode.new_node, MenuNode.new_node, MenuNode.new_node, MenuNode.new_node, MenuNode.new_node, MenuNode.new_node]
    test_node.add_children= some_arr
    # проверка на добавление массива потомков
    assert(test_node.get_children == some_arr,'get_children must return the same result as add_children set')
  end

  test "set_children must sets only MenuNode type elements" do
    test_node = MenuNode.new_node
    node1 = MenuNode.new_node
    some_arr = [node1, "asf", MenuNode, 1234]
    test_node.add_children= some_arr
    assert(test_node.get_children == [node1],'get_children must return the same result as add_children set')
  end

  test "delete node" do
    test_node = MenuNode.new_node
    node1 = MenuNode.new_node
    node2 = MenuNode.new_node
    node3 = MenuNode.new_node
    test_node.set_children= [node1, node2, node3]
    node2.del_node!
    # удален ли нод
    node_still_exists = test_node.get_children.any?{|child|
      child == node2
    }
    assert(node_still_exists == false, "node did not delete")
  end

  test "not array to set_children" do
    test_node = MenuNode.new_node
    test_node.set_children= "asfd"
    assert(test_node.get_children == [], 'asdf')
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