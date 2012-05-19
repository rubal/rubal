require 'rubal_core/page_processor'
include RubalCore

PAGES_PATH='pages/html'
TARGETS_PATH='pages/erb'
page_processor = PageProcessor.instance

Dir.foreach(PAGES_PATH) { |file_name|
  next if file_name =~ /^\.\.?$/
  next unless file_name =~ /^*\.html$/
  # путь для .vhtml
  page_path = PAGES_PATH + '/' + file_name
  #todo: добавить timestamp в имени .erb
  #timestamp  = Time.now.getutc
  #p timestamp
  # целевой путь для .erb
  target_path = TARGETS_PATH + '/' +  file_name.split(/^*\.html$/).first + '.erb' # TODO: говнокод, но работает
  # преобразуем из vhtml файла в erb файл
  page_processor.process page_path, target_path
}