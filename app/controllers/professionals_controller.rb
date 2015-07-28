class ProfessionalsController < ApplicationController
	before_action :authenticate_user!
	

	def show
		@pro_user = current_user.professional	
	end

	def new
		@pro_user = Professional.new
	end

	def create
		@pro_user = current_user.build_professional(pro_params)

		if @pro_user.valid?
			@pro_user.save
			redirect_to user_professional_path(current_user.id, @pro_user.id), notice: 'Professional profile succesfully create!'
		else
			redirect_to new_user_professional_path(current_user.id), notice: 'Something went wrong :( Please try again'
		end
	end

	def update
	end

	def destroy
	end




	private
	def pro_params
		params.require(:professional).permit(:title, :description, :prof_pic)
	end
end
