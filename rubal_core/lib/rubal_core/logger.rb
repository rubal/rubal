module RubalCore
  class RubalLoggerManager
    require 'singleton'
    require "rails"
    require 'logger'
    include Singleton
    include Rails
    def initialize
      #30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
      @colors = {:black => '30', :red => '31', :green => '32', :yellow => '33', :blue => '34', :magenta => '35', :cyan => '36', :white => '37'}
      @bg_colors = {:black => '40', :red => '41', :green => '42', :yellow => '43', :blue => '44', :magenta => '45', :cyan => '46', :white => '47'}
      #00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
      @styles = {:none => '00', :bold => '01', :underscore => '04', :blink => '05', :reverse => '07', :concealed => '08'}

      [@colors, @bg_colors, @styles].each{|a|
        a.each_pair{|k, v| a[k] = "\033[0;#{v}m" }
      }
    end

    def post_message message, styles = nil, sender = ''
      sts = (styles.nil?) ? '30' : @colors[styles]
      #  \033[0;34m Here is where I am  \033[0;37m
      puts "#{sts}#{message}#{@colors[:black]}" + ((sender.blank?) ? "" : " (from #{sender})")

    end
  end

  module RubalLogger
    def color_log message, style
      RubalCore::RubalLoggerManager.instance.post_message message, style, self.class.name
    end
  end
end