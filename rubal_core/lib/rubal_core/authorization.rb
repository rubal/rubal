module RubalCore
  module Authorization
    require "devise"
    include Devise

    # просто синоним метода из Devise. немного отделяет реализацию аутентификации

    def rubal_authenticate
       authenticate_user!
    end
  end

end