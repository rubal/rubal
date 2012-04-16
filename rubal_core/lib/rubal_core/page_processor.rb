require 'singleton'
require 'logger'
require 'rubal_core/plugin_manager'

module RubalCore
  class PageProcessor
    include Singleton

    def initialize
      @logger = Logger.new STDERR
    end

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


    def process page_path, target_path
      text = File.read page_path
      values_hash = PluginManager.instance.placeholders
      result = replace text, values_hash
      File.open(target_path,"w"){|file|
        file.print result
      }
    rescue Errno::ENOENT
      @logger.fatal "Cannot process file '#{page_path}'"
      raise
    rescue
      @logger.fatal "Cannot target file '#{target_path}'"
      raise
    end
  end
end
