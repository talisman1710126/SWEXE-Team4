class Public::SpotsController < ApplicationController
  MAX_SPOT_DISTANCE_KM = 20_100

  def index
    @categories = Spot.categories.keys
    @selected_category = params[:category].to_s
    @coordinates = current_coordinates

    @spots = Spot.with_attached_image
    if @selected_category.present?
      @spots = Spot.categories.key?(@selected_category) ? @spots.where(category: @selected_category) : Spot.none
    end
    @spots = @spots.near(@coordinates, MAX_SPOT_DISTANCE_KM, units: :km) if @coordinates
  end

  def show
    @spot = Spot.find(params[:id])
  end

  private

  def current_coordinates
    latitude = params[:latitude]
    longitude = params[:longitude]
    return if latitude.blank? && longitude.blank?

    raise ActionController::BadRequest, "Both latitude and longitude are required" if latitude.blank? || longitude.blank?

    coordinates = [ Float(latitude), Float(longitude) ]
    unless coordinates[0].between?(-90, 90) && coordinates[1].between?(-180, 180)
      raise ActionController::BadRequest, "Coordinates are outside the valid range"
    end

    coordinates
  rescue ArgumentError, TypeError
    raise ActionController::BadRequest, "Coordinates must be valid numbers"
  end
end
