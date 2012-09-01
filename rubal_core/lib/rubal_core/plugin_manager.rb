require 'singleton'
require_relative '../rubal_core'

module RubalCore
  class PluginManager
    include Singleton
    include RubalLogger
    def initialize
      @@registered_plugins = Hash.new
      @@registered_page_types = Array.new
      @@registered_css_assets = Array.new
      @@registered_js_assets = Array.new
    end

    def get_substitutions(plugin_name)
      if (@@registered_plugins.include? plugin_name)
        return @@registered_plugins[plugin_name].get_substitutions
      else
        return nil
      end
    end


    def get_available_substitutions_descriptions(page_type = nil)
      ret = []
      @@registered_plugins.each_pair{|pl, subs|
        (subs.get_substitutions).each {|sub|
          ret.push  :substitution => sub.get_subst_string, :description => sub.description.html_safe if sub.used_in_page_type? page_type
        }
      }

      ret
    end

    def register_plugin(plugin)
      raise "Strange plugin" unless plugin.is_a? RubalPlugin

      descr = plugin.get_description

      color_log("register " + descr[:plugin_substitution_name], :red)

      raise "Strange plugin description hash" unless descr.include? :plugin_substitution_name
      raise "Plugin was already added" if @@registered_plugins.include? descr[:plugin_substitution_name]

      @@registered_plugins.merge! descr[:plugin_substitution_name].to_s => plugin
    end

    def get_routing_rules
      rr = {}
      @@registered_page_types.each{|pti|
          unless pti[:route_processor].nil?
            rr.merge! pti[:name] => pti[:route_processor]
          end
      }
      rr
    end

    def create_or_update_page_types
      @@registered_page_types.each{|pti|
        pt = PageType.find_by_name pti[:name]
        unless pt.nil?
          raise "PageType was already registered, but for another plugin" unless pt.plugin_name == pti[:plugin].get_description[:plugin_substitution_name]

          #pt.humanized_name= pti[:humanized_name]
          #pt.description= pti[:description]
        else
          pt = PageType.new(:plugin_name => pti[:plugin].get_description[:plugin_substitution_name], \
                            :name => pti[:name], :humanized_name => pti[:humanized_name], \
                            :description => pti[:description])
          pt.save
        end

      }
    end

    def register_page_type(plugin, name, humanized_name, description, route_processor = nil, additional_form_params = nil)
      # route_processor - если строка, то контроллер к которому обращаться, иначе лямбда-выражение (ну или nil)

      @@registered_page_types.push(:plugin => plugin, :name => name, :humanized_name => humanized_name, \
            :description => description, :route_processor => route_processor, :additional_form_params => additional_form_params)
    end

    def get_page_type_hash(name)
      @@registered_page_types.each{|pti|
        if pti[:name] == name
          return pti
        end
      }
      return nil
    end

    def register_menu_node(name, url, children = [])
      nd = RubalMenuNode.new_node({:name => name, :url => url})
      children.each {|c| nd.add_child= RubalMenuNode.new_node(c) }
      RubalMainMenu.instance.add_child= nd
    end

    def register_js_assets js_file_name

       return
      rubal_js_path = File.expand_path "../../../app/assets/javascripts/rubal_plugins.js", __FILE__

      original_js = File.binread(rubal_js_path)
      puts rubal_js_path
      if original_js.include?("require '#{js_file_name}'")
        say_status("skipped", "insert '#{js_file_name}' into app/assets/javascripts/rubal_plugins.js", :yellow)
      else
        ::Thor::Actions.inject_into_file("rubal_core/app/assets/javascripts/rubal_plugins.js", :before => "* */") do
          "\n//= require '#{js_file_name}'\n\n"
        end
        say_status("success", "insert '#{js_file_name}' into app/assets/javascripts/rubal_plugins.js", :green)
      end

    end

    def register_css_assets css_file_name
      return
      original_css = File.binread(File.expand_path "../../../app/assets/javascripts/rubal_plugins.css", __FILE__)
      if original_css.include?("require '#{css_file_name}'")
        say_status("skipped", "insert '#{css_file_name}' into app/assets/javascripts/rubal_plugins.css", :yellow)
      else
        insert_into_file "app/assets/javascripts/application.css", :after => %r{//= require ['"]?jquery['"]?} do
          "\n//= require '#{css_file_name}'\n\n"
        end
      end
    end

    def get_name_by_substitution_name name
      @@registered_plugins[name.to_s].get_description[:name] || name
    end
  end
end
