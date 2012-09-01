{:common=>
	{:cms_name=>"rubal"},
:pages=>
  {:page_erb_dir => "/pages/", :redirect_on_permission_denied => '/?permission_denied'},
:plugins=>
  {},
:basic_user_groups =>
  {:admins => {:key => 'admins', :name => "Администраторы"},
   :guests => {:key => 'guests', :name => "Гости"},
   :members => {:key => 'members', :name => 'Пользователи'}}
}
