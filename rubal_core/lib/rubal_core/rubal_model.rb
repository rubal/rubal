require_relative '../rubal_core'

module ActiveRecord
  def Base.rubal_erb_content field_name, erb_params

    define_method(field_name) {
      return "" if self.new_record?

      return RubalCore::FileHelper.instance.read_file(self.send(erb_params[:path_field]))
    }

    #TODO: выбор пути

    define_method(field_name.to_s + "=") { |cont|
      unless self.persisted?
        self.send((erb_params[:path_field].to_s + "=").to_sym,          \
                  '/pages/' + self.class.name + '/' + RubalCore::FileHelper.instance.imagine_long_filename(self.class.name, 'erb') )
      end
      RubalCore::FileHelper.instance.write_file(self.send(erb_params[:path_field]), cont)
    }

    if erb_params.include? :from
      before_save_method_name = 'before_save_translate_to_erb'.to_sym
      define_method(before_save_method_name) {

        if self.send(erb_params[:path_field]).nil?
          self.send((erb_params[:path_field].to_s + "=").to_sym,          \
                  '/pages/' + self.class.name + '/' + RubalCore::FileHelper.instance.imagine_long_filename(self.class.name, 'erb') )
        end
        page_type = nil

        # проверить определен ли метод
        #if (self.type_id).defined?
          page_type = self.type_id
        #end

        RubalCore::PageProcessor.instance.translate_to_erb(self.send(erb_params[:from]), self.send(erb_params[:path_field]), page_type)
      }

      self.send(:before_save, before_save_method_name)
    end

  end

  def Base.rubal_rubhtml_content field_name, rubhtml_params
    define_method(field_name) {
      return "" if self.new_record?
      return RubalCore::FileHelper.instance.read_file(self.send(rubhtml_params[:path_field]))
    }

    #TODO: выбор пути

    define_method(field_name.to_s + "=") { |cont|
      unless self.persisted?
        self.send((rubhtml_params[:path_field].to_s + "=").to_sym,          \
                  '/pages/' + self.class.name + '/' + RubalCore::FileHelper.instance.imagine_long_filename(self.class.name, 'html') )
      end
      RubalCore::FileHelper.instance.write_file(self.send(rubhtml_params[:path_field]), cont)
    }
  end
end