require 'rubal_core/page_processor'
include RubalCore

PAGES_PATH='pages/html'
TARGETS_PATH='pages/erb'
page_processor = PageProcessor.instance
# создаем новую страницу в бд
def create_new_page erb_path, vhtml_path, page_url, page_title
  # если в бд таблице уже есть запись об этой странице, то не создаем старницу
  if Thepage.find_all_by_vhtml_path(vhtml_path).count > 0
    return
  end
  page = Thepage.new
  page.erb_path= erb_path #Rails.root.to_s + '/' + target_path #'/pages/erb/supertest.erb'
  page.vhtml_path= vhtml_path #Rails.root.to_s + '/' + page_path #'/pages/html/supertest.html'
  page.page_url= page_url #'some/relative/page/url'
  page.page_title= page_title #'Title Page'
  #page.parent_page= id_parent_page/somepage.id
  page.save
end

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

  create_new_page(Rails.root.to_s + '/' + target_path, Rails.root.to_s + '/' + page_path, 'some/page/url', 'Some Title')
  #PageProcessor.process page.vhtml_path page.erb_path
  # преобразуем из vhtml файла в erb файл
  page_processor.process page_path, target_path
}