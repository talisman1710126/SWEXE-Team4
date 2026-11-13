class Admin::SpotsController < ApplicationController
  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)
    if @spot.save
      redirect_to new_admin_spot_path, notice: "スポット「#{@spot.name_ja}」を登録しました"
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def spot_params
    params.expect(spot: [:name_ja, :name_en, :category, :description_en, :access, :latitude, :longitude])
  end
end
