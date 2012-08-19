require 'singleton'
require_relative '../rubal_core'

module RubalCore
  class PluginManager
    include Singleton

    def initialize
      @@registered_plugins = Hash.new
      @@registered_page_types = Array.new
    end

    def get_substitutions plugin_name
      if (@@registered_plugins.include? plugin_name)
        return @@registered_plugins[plugin_name].get_substitutions
      else
        return nil
      end
    end


    def get_available_substitutions_descriptions page_type = nil
      ret = []
      @@registered_plugins.each_pair{|pl, subs|
        (subs.get_substitutions).each {|sub|
          ret.push  :substitution => sub.get_subst_string, :description => sub.description.html_safe if sub.used_in_page_type? page_type
        }
      }

      ret
    end

    def register_plugin plugin
      raise "Strange plugin" unless plugin.is_a? RubalPlugin

      descr = plugin.get_description

      puts "#############register " + descr[:plugin_substitution_name]

      raise "Strange plugin description hash" unless descr.include? :plugin_substitution_name
      raise "Plugin was already added" if @@registered_plugins.include? descr[:plugin_substitution_name]

      @@registered_plugins.merge! descr[:plugin_substitution_name].to_s => plugin
    end

    def get_routing_rules
      rr = {}
      @@registered_page_types.each{|pti|
          unless pti[:controller].nil?
            rr.merge! pti[:name] => pti[:controller]
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

    def register_page_type plugin, name, humanized_name, description, controller = nil, after_save_block = nil
      @@registered_page_types.push :plugin => plugin, :name => name, :humanized_name => humanized_name, :description => description, :controller => controller, :after_save_block => after_save_block
    end

    def get_page_type_hash name
      @@registered_page_types.each{|pti|
        if pti[:name] == name
          return pti
        end
      }
      return nil
    end
  end
end
