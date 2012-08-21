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


    # транслирует content_from (текст) в erb, записывает его в path_to
    # page_type_id - id типа страницы для определения разрешенных/запрещенных подстановок
    def translate_to_erb content_from, path_to, page_type_id
      replaced = content_from.dup
      placeholders = RubalRubhtmlParser.instance.parse replaced

      placeholders.each_pair {|pl_name, found_plhs|
        # зарегистрированные ранее подстановки
        substs = PluginManager.instance.get_substitutions pl_name

        unless substs.nil?
          # по каждому найденному плейсхолдеру
          found_plhs.each{|plh|
            # по каждой зарегистрированной подстановке. да, криво
            substs.each{|subs|
              if plh[:subst_name] == subs.subst_name
                # разрешена ли эта подстановка для данного типа страницы
                raise SubstitutionNotAllowedForThePageType.new(subs.get_subst_string) unless subs.used_in_page_type? page_type_id
                # замена плейсхолдера его значением
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
      # запись результата
      FileHelper.instance.write_file path_to, replaced
    end
  end
end