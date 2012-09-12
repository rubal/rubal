Rails.application.routes.draw do
  scope '/admin' do
    resources :permissions
    resources :user_groups
    match 'permissions/edit_group_permissions/:group' => 'permissions#edit_group_permissions', :as => :edit_group_permissions
    match 'permissions/update_group_permissions' => 'permissions#update_group_permissions'

    devise_for :users, :controllers => { :registrations => "rubal_registrations" }

    root :to => 'rubal_admin#index', :as => :admin

    match 'browse_users' => 'rubal_admin#browse_users', :as => :browse_users
    match 'rubal_admin/set_user_group/:user_id' => 'rubal_admin#set_user_group'

    resources :page_contents

    match "/sign_out" => 'rubal_admin#devise_sign_out', :as => :sign_out
  end
end
