class PlacesController < ApplicationController

	def index
		@places = Place.page(params[:page]).per(1)
	end

	def new
		@place = Place.new
	end

	def create
		@place = Place.create(place_params)
		redirect_to root_path
	end

	private

	def place_params
		params.require(:place).permit(:name, :description, :address)
	end

end
