require "rubal_core/plugin_manager"
include RubalCore


module RubalLogo
  #attr_reader :placeholders, :routes

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

  def install
    plugin_manager = PluginManager.instance

    # добавление в AdminController
    plugin_manager.add_admin_controller self

    # добавление в PageController
    plugin_manager.add_page_controller  self

    # собираем пути из плагинов
    @routes.each{ |route|
      plugin_manager.add_route route
    }

    @placeholders.each{ |placeholder|
      plugin_manager.add_placeholder( placeholder[:category], placeholder[:param], placeholder[:value] )
    }
  end

  module_function :install
end

RubalLogo.install
