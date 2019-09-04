class PostsController < ApplicationController
	before_action :authenticate_user!,:only =>[:new,:create]
	def index
		@posts =Post.all
	end
	def new 
		@group = Group.find(params[:group_id])
		@post = Post.new
	end
	def create
		@group = Group.find(params[:group_id])
		@post = Post.new(post_params)
		@post.group = @group
		@post.user = current_user
		if @post.save
			redirect_to group_path(@group)
		else
			render :new
		end
	end
	# 文章编辑
	def edit
		@post = Post.find(params[:id])
	end
	# 文章更新
	def update
		@post = Post.find(params[:id])
		if @post.update(post_params)
			redirect_to posts_path,notice:"update success."
		else 
			render :edit
		end
	end
	private
	def post_params
		params.require(:post).permit(:content)
	end
end
