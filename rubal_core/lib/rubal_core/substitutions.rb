require_relative "../rubal_core"

module RubalCore
  class RubalSubstitution
    attr_accessor :description, :subst_name
    @specification_for_page_types
    attr_reader :plugin

    def initialize plugin, subst_name, subst_value, description = "", spec_hash = {}
      raise "Strange plugin" unless plugin.is_a? RubalPlugin
      @plugin = plugin
      @subst_name = subst_name
      @subst_value = subst_value
      @description = description
      @specification_for_page_types = Hash.new
      self.set_specification spec_hash
    end

    def set_specification spec_hash
      raise "Strange specification hash" unless spec_hash.is_a? Hash

      [:only, :except].each {|condition|
        if spec_hash.include?(condition)
          if spec_hash[condition].is_a? Array
            spec_hash[condition].each{|t|
              raise "Strange specification hash content" unless (t.is_a? Symbol)
            }
            @specification_for_page_types[condition] = spec_hash[condition]
          elsif spec_hash[condition].is_a? Symbol
            @specification_for_page_types[condition] = [spec_hash[condition]]
          end
        end
      }
    end

    def used_in_page_type? type
      return true if @specification_for_page_types.nil? or type.nil?

      type_sym = nil
      type_sym = type if (type.is_a? Symbol)
      type_sym = PageType.find(type).name.to_sym if (type.is_a? Integer)
      type_sym = type.name.to_sym if (type.is_a? PageType)

      raise "Strange page type" if type_sym.nil?

      if @specification_for_page_types.include? :only
        return @specification_for_page_types[:only].include? type_sym
      end

      if @specification_for_page_types.include? :except
        return !(@specification_for_page_types[:only].include? type_sym)
      end

      return true
    end

    def get_value
      return @subst_value
    end

    def get_subst_string
      return "[[#{(@plugin.get_description)[:plugin_substitution_name]}:#{@subst_name}]]"
    end
  end

  class RubalSubstitutionViewRender < RubalSubstitution
    def initialize plugin, subst_name, view_path, description = "", spec_hash = {}
      raise "Strange plugin" unless plugin.is_a? RubalPlugin
      @plugin = plugin
      @subst_name = subst_name
      @subst_value = "<%= render '#{view_path}' %>"
      @description = description
      self.set_specification spec_hash
    end
  end

  #TODO: типы параметров и их автоматическая проверка
  class RubalSubstitutionWithParams < RubalSubstitution
    def initialize plugin, subst_name, params, description = ""
      raise "Strange plugin" unless plugin.is_a? RubalPlugin
      raise "Strange params array" unless params.is_a? Array
      @plugin = plugin
      @params = params
      @subst_name = subst_name
      @subst_value = nil
      @description = description
    end

    def get_value params_vals

    end
  end
end