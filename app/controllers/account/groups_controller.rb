class Account::GroupsController < ApplicationController
	# 我的板块的首页
	def index
		@group =Group.all
	end
end
