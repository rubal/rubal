require "rubal_core/plugin"

module RubalLogo
  class RubalLogo < RubalCore::Plugin

    module Methods
      def rubal_logo size=:middle
        logo_path='logo_middle.png'
        logo_sizes = { :x=>192, :y=>192 }
        case size
          when :small
            logo_path = 'logo_small.png'
            logo_sizes = { :x=>140, :y=>47 }
          when :big
            logo_path = 'logo_big.png'
            logo_sizes = { :x=>1280, :y=>1280 }
          else
            raise "Unknown logo size"
        end
        render :inline => "<img src=\"#{logo_path}\" width=\"#{logo_sizes[:x]}\" height=\"#{logo_sizes[:y]}\">"
      end
    end

    def initialize
      @module = Methods
      @placeholders = [
          {
              :category=>'logo',
              :param=>'small',
              :value=>'<% rubal_logo :small %>'
          },
          {
              :category=>'logo',
              :param=>'middle',
              :value=>'<% rubal_logo :middle %>'
          },
          {
              :category=>'logo',
              :param=>'big',
              :value=>'<% rubal_logo :big %>'
          }
      ]
      @routes = []

      super
    end

  end
end

RubalLogo::RubalLogo.new
