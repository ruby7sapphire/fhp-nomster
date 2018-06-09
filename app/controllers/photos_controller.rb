class PhotosController < ApplicationController
  before_action :authenticate_user!

  def create
    @place = current_place
    @place.photos.create(photo_params.merge(user: current_user))
    redirect_to place_path(@place)
  end

  def edit
    @place = current_place
    @photo = current_photo
  end

  def update
    @place = current_place
    @photo = current_photo
    if @photo.user != current_user
      return render plain: 'Not Allowed', status: :forbidden
    end

    @photo.update_attributes(photo_params)
    if @photo.valid?
      redirect_to place_path(@place)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @place = current_place
    @photo = current_photo
    if @photo.user != current_user
      return render plain: 'Not Allowed', status: :forbidden
    end

    @photo.destroy
    redirect_to place_path(@place)
  end

  private

  def photo_params
    params.require(:photo).permit(:caption, :picture)
  end

  def current_place
    Place.find(params[:place_id])
  end

  def current_photo
    current_place.photos.find(params[:id])
  end
end
