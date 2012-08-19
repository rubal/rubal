require 'singleton'

module RubalCore
  class RubalParseError < Exception

  end

  class RubalRubhtmlParser
    include Singleton

    def parse txt
      parsed_plhs = Hash.new

      o_brackets = []
      txt.scan(/\[\[/) do |c|
        o_brackets << $~.offset(0)[1]
      end

      c_brackets = []
      txt.scan(/\]\]/) do |c|
        c_brackets << $~.offset(0)[0]
      end


      if(c_brackets.length != o_brackets.length)
        raise RubalParseError "number of opening and closing tags does not match"
      end

      found_placeholders = Array.new

      cl_num = 0

      o_brackets.each{ |op_i|
        cl_i = c_brackets[cl_num]
        if cl_i < op_i
          raise RubalParseError "]] goes before [["
        end

        found_placeholders.push :begin => op_i, :end => cl_i, :value => txt[op_i...cl_i]
        cl_num += 1
      }

      parsed_plh_values = Array.new

      found_placeholders.each{|pl|
        pl_res = {:value => pl[:value], :subst_name => "", :additional_params => {}}

        pl_n_regex = '^(?<pl_name>(\\w)+)(:(?<subst_name>(\\w)+))?[ ]?[$]?'

        param_regex = '(?<params>(?<param_name>(\\w)+)=[\\"](?<param_val>[^\\"]+)[\\"])[ ]?[$]?'
        param_match =  pl[:value].scan Regexp.new(param_regex)

        param_match.each{|m|
          if( m.kind_of? Array )
            if(m.length == 3)
              #pl_res[:additional_params].push :param_name => m[1], :param_value => m[2]
              pl_res[:additional_params].merge! m[1] => m[2]
            end
          end
        }

        pl_name_match = Regexp.new(pl_n_regex).match pl[:value]
        plugin_name = pl_name_match[:pl_name]
        pl_res[:subst_name] = pl_name_match[:subst_name]

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