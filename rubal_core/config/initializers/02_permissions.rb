require_relative "../../lib/rubal_core"

perm_manager = RubalCore::PermissionManager.instance

perm_manager.permissions.each do |p|
  perm = Permission.find_or_initialize_by_key(p[:key])

  # TODO при создании нового создавать ассоциацию с группой default_access
  perm.update_attributes!(p)
end