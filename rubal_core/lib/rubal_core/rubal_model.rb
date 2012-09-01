require_relative '../rubal_core'

module ActiveRecord
  include RubalCore::RubalLogger
  def Base.rubal_erb_content field_name, erb_params
    color_log "Adding rubal_model methods", :blue
    define_method(field_name) {                                                               # def erb_content
      return "" if self.new_record? || !File.exists?(Rails.root.to_s + self.send(erb_params[:path_field]))      #   return "" if self.new_record?
      return RubalCore::FileHelper.instance.read_file(self.send(erb_params[:path_field]))     #   return RubalCore::FileHelper.instance.read_file(erb_path)
    }                                                                                         # end

    make_erb_filename = (erb_params[:path_field].to_s + '_make_filename').to_sym

    define_method(field_name.to_s + "=") { |erb_content|
      RubalCore::FileHelper.instance.write_file(self.send(erb_params[:path_field]), erb_content)
    }

    define_method(make_erb_filename) {
      if self.new_record? || self.send(erb_params[:path_field]).nil?
        new_filename = RubalCore::Settings.instance[:pages][:page_erb_dir] + \
              '/' + PageType.find(self.type_id).name + '/' + RubalCore::FileHelper.instance.imagine_long_filename('', 'erb')
        color_log "I think you'll be " + new_filename, :green

        self.send((erb_params[:path_field].to_s + "=").to_sym, new_filename)
      end
    }

    self.send(:after_validation, make_erb_filename)

    if erb_params.include? :from_field
      define_method(:rubal_translate_to_erb) {
        color_log "Call me before you're saved'", :green
        RubalCore::PageProcessor.instance.translate_to_erb(self, erb_params[:from_field], (field_name.to_s + "=").to_sym, erb_params[:erb_hash_field])
      }
      self.send(:before_save, :rubal_translate_to_erb)
    end

  end

  #def Base.rubal_rubhtml_content field_name, rubhtml_params
  #  define_method(field_name) {
  #    return "" if self.new_record?
  #    return RubalCore::FileHelper.instance.read_file(self.send(rubhtml_params[:path_field]))
  #  }
  #
  #  #TODO: выбор пути
  #
  #  define_method(field_name.to_s + "=") { |cont|
  #    unless self.persisted?
  #      self.send((rubhtml_params[:path_field].to_s + "=").to_sym,          \
  #                '/pages/' + self.class.name + '/' + RubalCore::FileHelper.instance.imagine_long_filename(self.class.name, 'html') )
  #    end
  #    RubalCore::FileHelper.instance.write_file(self.send(rubhtml_params[:path_field]), cont)
  #  }
  #end
end