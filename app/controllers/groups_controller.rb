class GroupsController < ApplicationController
	before_action :authenticate_user!,only:[:new,:create,:edit,:update,:destroy]
	before_action :find_group_and_check_permission,only:[:edit,:update,:destroy]
	def index
		@groups = Group.all
	end
	def new 
		@group = Group.new
	end
	# create a new group with save 
	def create 
		@group = Group.new(group_params)
		@group.user = current_user
		if @group.save
			current_user.join!(@group)
			redirect_to groups_path
		else
			render :new
		end
	end
	def show
		@group = Group.find(params[:id])
		@posts = @group.posts.recent.paginate(:page => params[:page],:per_page =>5)
	end
	def edit
		@group = Group.find(params[:id])
	end
	def update
		@group = Group.find(params[:id])
		if @group.update(group_params)
			redirect_to groups_path,notice:"Update Success"
		else
			render:edit
		end
	end
	def destroy
		@group = Group.find(params[:id])
		@group.destroy
		#flash[:alert] = "Group deleted"
		redirect_to groups_path,notice:"Deleted Success"
	end
	# 加入板块
	def join
		@group = Group.find(params[:id])
		if !current_user.is_member_of?(@group)
			current_user.join!(@group)
			flash[:notice] = "加入本论坛版成功"
		else
			flash[:warning] = "你已经是本论坛的成员了"
		end
		redirect_to group_path(@group)
	end
	# 退出板块
	def quit
		@group = Group.find(params[:id])
		if current_user.is_member_of?(@group)
			current_user.quit!(@group)
			flash[:alert] = "你已经退出本论坛块"
		else
			flash[:warning] = "你还没有加入本论坛你oto"
		end
		redirect_to group_path(@group)
	end
	#私有块
	private
        #权限验证	
	def find_group_and_check_permission
		@group = Group.find(params[:id])
		if current_user != @group.user
			redirect root_path,alert:"you have no permission."
		end
	end
	# 权限指定
	def group_params
		params.require(:group).permit(:title,:descriptioon)
	end
end
