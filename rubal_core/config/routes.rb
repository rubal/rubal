Rails.application.routes.draw do
  scope '/admin' do
    resources :permissions
    resources :user_groups
    match 'permissions/edit_group_permissions/:group' => 'permissions#edit_group_permissions'
    match 'permissions/update_group_permissions' => 'permissions#update_group_permissions'
    devise_for :users

    match 'browse_users' => 'rubal_admin#browse_users'
    match 'rubal_admin/set_user_group/:user_id' => 'rubal_admin#set_user_group'

    resources :page_contents
  end
end
