#ReadMe

##About
使用cancancan + devise 分别控制权限和用户管理。

demo中对devise的路由进行了订制。

```ruby

	devise_for :users, path: 'accounts', skip: [:sessions, :registrations], controllers: 	{ passwords: "users/passwords" }
  	devise_scope :user do 
    	resource :registeration, 
             as: 'user_registration',
             except: [:new, :destroy],
             path: 'accounts',
             controller: 'users/registrations'
  	end
  	as :user do
    	get 'login' => 'users/sessions#new', :as => :new_user_session
    	post 'login' => 'users/sessions#create', :as => :user_session
    	delete 'logout' => 'users/sessions#destroy', :as => :destroy_user_session
    	get 'register' => 'users/registrations#new', :as => :new_user_registeration
  	end
  	

```

只支持根据用户名登录。

##References

* [Devise](https://github.com/plataformatec/devise)
* [CanCanCan homepage](https://github.com/CanCanCommunity/cancancan)
* [CanCanCan authorizing-ontroller-actions](https://github.com/CanCanCommunity/cancancan/wiki/authorizing-controller-actions)
* [CanCanCan define-ablities](https://github.com/CanCanCommunity/cancancan/wiki/defining-abilities)
