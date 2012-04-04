require 'singleton'

class SettingsCategory < Hash
  attr_reader :name

  def initialize name, data
    @name = name
    merge! data
  end
end

class Settings < Hash
  include Singleton
  Filename = 'settings_db.rb'

  def initialize
    load
  end

  def add_category category
    self[category.name] = category
  end

  def remove_category category_name
    delete! category_name
  end

  def load filename = Filename
    settings = eval File.read filename
    settings.each{|category_name,category_data|
      add_category SettingsCategory.new category_name, category_data
    }
  rescue Errno::ENOENT
    puts "Settings file '#{filename}' not found"  # TODO: log about it
    throw_error
  end

  def flush filename = Filename
    File.open(filename,"w"){|file|
      file.print self.to_s
    }
  rescue
    puts "Cannot save settings to file '#{filename}'"  # TODO: log about it
    throw_error
  end
  alias save flush

  def to_s
    s = "{"
    self.each{|category_name,category_data|
      s << ":#{category_name}=>\n\t" << category_data.to_s.gsub(/ /){ "\n\t" } << ",\n"
    }
    s << "}"
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