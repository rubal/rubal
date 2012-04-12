# Author::    Dmitriy Romanov  (mailto:romanov@rubal.ru)

require 'singleton'

#SettingsCategory -- container for module settings
class SettingsCategory < Hash
  attr_reader :name

  # * name -- category name, should be symbol
  # * data -- settings group hash
  def initialize name, data
    @name = name
    merge! data
  end
end

# Settings provide adding, removing, editing CMS and CMS modules settings
#
# == Usage
#   settings = Settings.instance
#   puts settings[:common][:cmsname]
#
#   settings[:cache][:cache_by_dafault]=true
#   settings.flush # Store settings changes into file
class Settings < Hash
  include Singleton

  # Settings file
  Filename = Rails.root.to_s + '/lib/assets/settings_db.rb'

  def initialize # :nodoc:
    load
  end

  # Add category.
  # * category -- instance of SettingsCategory
  def add_category category
    raise TypeError unless category.class == SettingsCategory
    self[category.name] = category
  end

  # Remove category
  # * category_name -- symbol
  # Also, u can use std hash remove:
  #   settings.delete :category
  def remove_category category_name
    delete category_name
  end

  # Reload configs from file
  # * filename -- path to file
  def load filename = Filename
    clear
    settings = eval File.read filename
    settings.each{|category_name,category_data|
      add_category SettingsCategory.new category_name, category_data
    }
  rescue Errno::ENOENT
    puts "Settings file '#{filename}' not found"  # TODO: log about it
    throw_error
  end

  # Save changes to file
  # * filename -- path to file
  def flush filename = Filename
    File.open(filename,"w"){|file|
      file.print self.to_s
    }
  rescue
    puts "Cannot save settings to file '#{filename}'"  # TODO: log about it
    throw_error
  end
  alias save flush

  def to_s # :nodoc:
    s = "{"
    self.each{|category_name,category_data|
      s << ":#{category_name}=>\n\t" << category_data.to_s.gsub(/ /){ "\n\t" } << ",\n"
    }
    s << "}\n"
  end

  ## Supporting YAML format
  #def to_s
  #  settings = Hash.new
  #  self.each{|category_name, category|
  #    category_data = Hash.new
  #    category.each{|param, value|
  #      category_data[param] = value;
  #    }
  #    settings[category_name]= category_data
  #  }
  #  YAML::dump settings
  #end
  #
  #def eval content
  #  YAML::load content
  #end
end

settings = Settings.instance