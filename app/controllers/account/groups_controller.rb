class Account::GroupsController < ApplicationController
	# 先设置必须登录用户才能看
	before_action :authenticate_user!
	# 只允许查看用户以及加入的板块
	def index
		@groups = current_user.participated_groups
	end
end
