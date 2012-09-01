#encoding: utf-8
require File.expand_path("rubal_core/lib/rubal_core", Rails.root.to_s)
module PagesHelper

  def get_types_for_select
    types_arr = Array.new
    PageType.all.each{|pt|
      types_arr.push [pt.humanized_name + " - " + pt.description, pt.id]
    }
    return types_arr
  end

  def get_types_for_new
    types_arr = Array.new
    PageType.all.each{|pt|
      types_arr.push [pt.humanized_name, pt.name]
    }
    return types_arr
  end

  def get_layouts_for_select
    layouts = [["Нет", ""]]
    Page.find_all_by_type_id(PageType.find_by_name('layouts').id).each{|l|
      layouts.push [l.name, l.id]
    }
    return layouts
  end
end
