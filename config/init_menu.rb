# Функция-заглушка. Возвращает массив хэшей с именем и ссылкой
def get_menu_array
  # урл, название и потомки нода
  arr = Array[
      {:url => "/menu_url1", :name => "Menu_Node1" },
      {:url => "/menu_url2", :name => "Menu_Node2" },
      {:url => "/menu_url3", :name => "Menu_Node3" }
  ]
end