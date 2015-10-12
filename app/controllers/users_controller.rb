class UsersController < ApplicationController
	def index
		render plain: "Halo"
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if :avatar.empty?
			@user.update(params[:name,:bio])
		else
			if @user.update(user_params)
				redirect_to @user
			end
		end
	end

	private
		def user_params
			params.require(:user).permit(:avatar,:name,:bio)
		end
end
