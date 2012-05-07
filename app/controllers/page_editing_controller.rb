class PageEditingController < ApplicationController
  @files = []
  @file_content = ''
  @file_name = ''
  def initialize
    pages_dir = Dir.new(Rails.root.to_s + '/pages/html')
    #pages_dir = Dir.new('C:/Users/Vadim/Documents/rubal/pages/html')
    count = pages_dir.entries.count
    p count
    dp = pages_dir.path
    p dp
    @files = Array.new(pages_dir.entries.count) {|f|
      f = File.new
    }
    #@files = File.new(pages_dir.count)
    @files = pages_dir.each{|f|
      @files += f
    }
  end
  def index
    #PagesDir = Dir.open(Rails.root.to_s + 'pages/html')
    page_dir = Dir.entries(Rails.root.to_s + '/pages/html')
    page_dir.each{|f|
      p f
    }
  end
  def edit(file)
    @file_name = file.to_s
    file.each{|line|
      @file_content += line
    }
    file.close
  end
end