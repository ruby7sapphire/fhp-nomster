class PlacesController < ApplicationController

	def index
		@places = Place.page(params[:page]).per(1)
	end

	def new
		@place = Place.new
	end

end
