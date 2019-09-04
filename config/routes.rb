Rails.application.routes.draw do
	# 拦截
	devise_for :users
	# 分组资源
	resources :groups do
		member do
			post :join
			post :quit
		end
		resources :posts
	end
#	root 'welcome#index'	
	# post
	resources :posts 
	# 账户设定
	namespace :account do
		resources :groups
		resources :posts
	end
	# 首页路径设定
	root 'groups#index'	      
	
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
