module PlacesHelper
  def slider_image_tag(path, *image_tag_params)
    image_tag "#{ENV['SLIDER']}/#{path}", image_tag_params[0]
  end
end
