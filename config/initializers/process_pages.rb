require 'rubal_core/page_processor'
include RubalCore

PAGES_PATH='pages/html'
TARGETS_PATH='pages/erb'
page_processor = PageProcessor.instance

Dir.foreach(PAGES_PATH) { |file_name|
  next if file_name =~ /^\.\.?$/
  next unless file_name =~ /^*\.html$/

  page_path = PAGES_PATH + '/' + file_name
  target_path = TARGETS_PATH + '/' + file_name.split(/^*\.html$/).first + '.html.erb' # TODO: говнокод, но работает
  #puts "#{page_path} => #{target_path}"
  page_processor.process page_path, target_path
}
