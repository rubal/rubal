require "thor"

def register_js_assets js_file_name
  rubal_js_path = File.expand_path "../../../app/assets/javascripts/rubal_plugins.js", __FILE__

  original_js = File.binread(rubal_js_path)
  puts rubal_js_path
  if original_js.include?("require '#{js_file_name}'")
    say_status("skipped", "insert '#{js_file_name}' into app/assets/javascripts/rubal_plugins.js", :yellow)
  else
    inject_into_file("rubal_core/app/assets/javascripts/rubal_plugins.js", :before => "* */") do
      "\n//= require '#{js_file_name}'\n\n"
    end
    say_status("success", "insert '#{js_file_name}' into app/assets/javascripts/rubal_plugins.js", :green)
  end

end

def register_css_assets css_file_name
  original_css = File.binread(File.expand_path "../../../app/assets/javascripts/rubal_plugins.css", __FILE__)
  if original_css.include?("require '#{css_file_name}'")
    say_status("skipped", "insert '#{css_file_name}' into app/assets/javascripts/rubal_plugins.css", :yellow)
  else
    insert_into_file "app/assets/javascripts/application.css", :after => %r{//= require ['"]?jquery['"]?} do
      "\n//= require '#{css_file_name}'\n\n"
    end
  end
end


