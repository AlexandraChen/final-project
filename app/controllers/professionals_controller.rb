
class ProfessionalsController < ApplicationController
	
	def show
		@pro_user = Professional.find(params[:id])
		@reservation = @pro_user.reservations.new	
		@review = Review.new
	end

	def new
		@pro_user = Professional.new
	end

	def create
		@pro_user = current_user.build_professional(pro_params)
		if @pro_user.save
			redirect_to professional_path(@pro_user.id),
					notice: 'Professional profile succesfully created!'
		else
			render :new, notice: 'Something went wrong :( Please try again'
		end
	end

	def edit
		@pro_user = current_user.professional
	end

	def update
  	@pro_user = current_user.professional
    @pro_user.update_attributes(pro_params)
    if @pro_user.valid?
      @pro_user.save
      redirect_to professional_path(@pro_user.id), notice: "Profile succesfully updated"
      return
    end
    render :edit
  end

	def destroy
		@pro_user = current_user.professional	
		@pro_user.destroy
		redirect_to user_path,
			notice: "Professional profile successfuly deleted"
	end

	def edit_profpic
		@pro_user = current_user.professional
	end

	def update_profpic
		@pro_user = current_user.professional
    @pro_user.update_attributes(pro_params)
    if @pro_user.save
      redirect_to professional_path(@pro_user.id), notice: "Profile picture succesfully"
      return
    end
    render :edit_profpic
	end

	private
	def pro_params
		params.require(:professional).permit(:title, :description, :prof_pic, :price_hr, :location)
	end
end
