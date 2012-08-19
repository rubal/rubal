module RubalCore
  module Authorization
    require "devise"
    include Devise
    def rubal_authenticate
       authenticate_user!
    end
  end

end