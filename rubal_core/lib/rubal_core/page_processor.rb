require 'singleton'

module RubalCore
  class PageProcessor
    include Singleton

    # regexp 4 placeholder
    ReplacerTemplate = /\[\[([a-zA-Z0-9_\-]*):([a-zA-Z0-9_\-]*)\]\]/
    #"\\[\\[" + param_name + ":(([a-zA-Z0-9_\\-]*)(, ?([a-zA-Z0-9_\\-]+))*)\\]\\]"

    # Replace placeholders in text to values from values_hash
    # * text -- processing text
    # * values_hash -- list of param with values(see example)
    # replace "[[category:param]]", {"category" => {"param" => "value"}} # "[[category:param]]" will be replaced to "value"
    def replace text, values_hash
      raise TypeError unless (text.instance_of? String) && (values_hash.instance_of? Hash)
      result = text.gsub(ReplacerTemplate){
        values_hash[$1][$2] unless values_hash[$1].nil?
      }
    end
  end
end
