require_relative "../../lib/rubal_core"
if ActiveRecord::Base.connection.tables.include?('pages') and ActiveRecord::Base.connection.tables.include?('page_types') and !defined?(::Rake)
  settings = RubalCore::Settings.instance
  page_dir = Rails.root.to_s + settings[:pages][:page_erb_dir]

  include RubalCore::RubalLogger

  Dir::mkdir(page_dir) unless FileTest::directory?(page_dir)

  PageType.all.each do |pt|
    Dir::mkdir(page_dir + '/' + pt.name) unless FileTest::directory?(page_dir + '/' + pt.name)
  end

  Page.all.each do |p|
    unless Digest::MD5.hexdigest(p.erb_content.gsub(/[\n\r]/, '') ) == p.erb_hash
      p.save
      color_log "Generating erb again for #{p.name}", :red
    else
      color_log "Erb is ok for #{p.name}", :green
    end
  end
end