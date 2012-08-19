require_relative "../rubal_core"
require "singleton"

module RubalCore
  class FileHelper
    include Singleton

    def read_file path
      path = "/" + path unless path[0] == "/"
      file = File.open(Rails.root.to_s + path)
      rethtml = ""
      file.each { |line| rethtml += line }
      file.close
      return rethtml
    end

    def write_file path, value
      path = "/" + path unless path[0] == "/"
      my_file = File.new(Rails.root.to_s + path, "w+")
      value.gsub!(Regexp.new('\r\n'), "\n")
      my_file.puts value
      my_file.close
    end

    def imagine_long_filename base, ext
      require 'digest/md5'
      r = Random.new
      add_num = r.rand(1...10000).to_s
      fn = add_num + "__" + Time.now.to_s
      ext = "." + ext unless ext[0] == "."
      res = Digest::MD5.hexdigest(add_num) + ext
      return base + "_" + res
    end

  end
end