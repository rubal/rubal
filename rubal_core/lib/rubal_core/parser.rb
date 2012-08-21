require 'singleton'
# парсер vhtml
module RubalCore
  class RubalParseError < Exception

  end

  class RubalRubhtmlParser
    include Singleton

    def parse txt
      parsed_plhs = Hash.new

      o_brackets = []

      # находим все открывающие скобки [[
      txt.scan(/\[\[/) do |c|
        o_brackets << $~.offset(0)[1]
      end

      # находим все закрывающие скобки ]]
      c_brackets = []
      txt.scan(/\]\]/) do |c|
        c_brackets << $~.offset(0)[0]
      end


      if(c_brackets.length != o_brackets.length)
        raise RubalParseError "number of opening and closing tags does not match"
      end

      found_placeholders = Array.new
      # количество прошедших закрывающих скобок
      cl_num = 0

      o_brackets.each{ |op_i|
        cl_i = c_brackets[cl_num]

        # вычислили соответственные индексы открывающих и закрывающих, сравнили
        if cl_i < op_i
          raise RubalParseError "]] goes before [["
        end

        # записали в массив что было между ними
        found_placeholders.push :begin => op_i, :end => cl_i, :value => txt[op_i...cl_i]
        cl_num += 1
      }

      parsed_plh_values = Array.new

      # проходимся по всем найденным плейсхолдерам
      found_placeholders.each{|pl|
        # инициализируем хэщ с результатом
        pl_res = {:value => pl[:value], :subst_name => "", :additional_params => {}}

        # самое главное тут регулярное выражение - название плагина, подстановки, и потом возможно тоже что-нибудь (это уже следующее)
        pl_n_regex = '^(?<pl_name>(\\w)+)(:(?<subst_name>(\\w)+))?[ ]?[$]?'
        # разбор параметров
        param_regex = '(?<params>(?<param_name>(\\w)+)=[\\"](?<param_val>[^\\"]+)[\\"])[ ]?[$]?'
        # поиск параметров
        param_match =  pl[:value].scan Regexp.new(param_regex)

        param_match.each{|m|
          if( m.kind_of? Array )
            if(m.length == 3)
              # запись всего что получилось. m[1] - название параметра, m[2] - значение
              pl_res[:additional_params].merge! m[1] => m[2]
            end
          end
        }

        # вытаскиваем название плагина и имя подстановки
        pl_name_match = Regexp.new(pl_n_regex).match pl[:value]
        plugin_name = pl_name_match[:pl_name]
        pl_res[:subst_name] = pl_name_match[:subst_name]

        # группируем возвращаемый хэш по названиям плагина

        if(parsed_plhs.include? plugin_name)
          parsed_plhs[plugin_name].push pl_res
        else
          parsed_plhs.merge! plugin_name => [pl_res]
        end
      }

      return parsed_plhs
    end
  end
end