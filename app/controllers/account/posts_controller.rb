class Account::PostsController < ApplicationController
	# 限制只有登录的用户才能查看用户发布了那些文章
	before_action :authenticate_user!
	# 查看用户发布了那些文章
	def index
		@posts = current_user.posts
	end
end
