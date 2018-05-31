class PlacesController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

	def index
		@places = Place.page(params[:page]).order(:id).per(1)
		@pagination_window = (@places.first_page? || @places.last_page?) ? 2 : 1
	end

	def new
		@place = Place.new
	end

	def create
		@place = current_user.places.create(place_params)
		if @place.valid?
			redirect_to root_path
		else
			render :new, status: :unprocessable_entity
		end
	end

	def show
		@place = current_place
		@comment = Comment.new
	end

	def edit
		@place = current_place
	end

	def update
		@place = current_place
		if @place.user != current_user
			return render plain: 'Not Allowed', status: :forbidden
		end

		@place.update_attributes(place_params)
		if @place.valid?
			redirect_to root_path
		else
			render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		@place = current_place
		if @place.user != current_user
			return render plain: 'Not Allowed', status: :forbidden
		end

		@place.destroy
		redirect_to root_path
	end

	private

	def current_place
		Place.find(params[:id])
	end

	def place_params
		params.require(:place).permit(:name, :description, :address)
	end

end
