require 'singleton'
require_relative 'rubal_plugin'
require_relative 'plugin_manager'
require_relative 'parser'
require_relative 'files_helper'

module RubalCore
  class SubstitutionNotAllowedForThePageType < Exception
    attr_reader :subst_name
    def initialize subst_name
      @subst_name = subst_name
    end
  end

  class PageProcessor
    include Singleton

    def translate_to_erb content_from, path_to, page_type_id
      replaced = content_from.dup
      placeholders = RubalRubhtmlParser.instance.parse replaced

      placeholders.each_pair {|pl_name, found_plhs|
        substs = PluginManager.instance.get_substitutions pl_name

        unless substs.nil?
          found_plhs.each{|plh|
            substs.each{|subs|
              if plh[:subst_name] == subs.subst_name
                raise SubstitutionNotAllowedForThePageType.new(subs.get_subst_string) unless subs.used_in_page_type? page_type_id
                unless subs.is_a? RubalSubstitutionWithParams
                  replaced["[[#{plh[:value]}]]"] = subs.get_value
                else
                  replaced["[[#{plh[:value]}]]"] = subs.get_value(plh[:additional_params])
                end

              end
            }
          }
        end
      }

      FileHelper.instance.write_file path_to, replaced
    end
  end
end