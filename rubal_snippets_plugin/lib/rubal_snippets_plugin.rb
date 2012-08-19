require "rubal_snippets_plugin/engine"
require File.expand_path("rubal_core/lib/rubal_core", Rails.root.to_s)

module RubalSnippetsPlugin
  class SnippetRepeat < RubalCore::RubalSubstitutionWithParams
    def get_value params_vals
      times = 1
      if params_vals.include? 'times'
        times = params_vals['times'].to_i
      end

      if params_vals.include? 'text'
        return params_vals['text']*times
      else
        return params_vals.to_s
      end

    end
  end

  class RubalSnippets < RubalCore::RubalPlugin
    def get_substitutions
      subst = @substitutions.dup
      Snippet.all.each{|sn|
        subst.push RubalCore::RubalSubstitution.new(self, sn.subst_name, sn.erb_content, sn.description)
      }

      return subst
    end

    def get_description
      return {:name => "Snippets plugin", :version => 0.01, :plugin_substitution_name => "snippet"}
    end

    def initialize
      RubalCore::PluginManager.instance.register_plugin self

      @substitutions = []

      @substitutions.push SnippetRepeat.new(self, "repeat", [], "repeat <b>text</b> several <b>times</b>")
      #@substitutions.push RubalCore::RubalSubstitution.new(self, "small2", "anothershit", "Just for second test<br> I don't like you'")

    end
  end
end

RubalSnippetsPlugin::RubalSnippets.new
