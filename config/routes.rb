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
	# posts 文章资源
	resources :post do 
		# 热门
		collection do
			get :hot
		end
	end
	# 首页路径设定
	root 'groups#index'	      
	
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
