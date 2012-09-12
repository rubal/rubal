require_relative '../../lib/rubal_core'

if ActiveRecord::Base.connection.tables.include?('user_groups') and !defined?(::Rake)
  basic_groups = RubalCore::Settings.instance[:basic_user_groups]

  basic_groups.each_pair do |gr, params|
    UserGroup.create(params) if UserGroup.find_by_key(params[:key]).nil?
  end
end