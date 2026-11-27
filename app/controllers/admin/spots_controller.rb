class Admin::SpotsController < ApplicationController
  before_action :set_spot, only: [:edit, :update, :destroy]

  def index
    @spots = Spot.order(:id)
    # 例: { [1, "want_to_go"] => 3, [1, "visited"] => 2 }（1回のクエリでまとめて集計）
    @counts = Visit.group(:spot_id, :status).count
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)
    if @spot.save
      redirect_to admin_spots_path, notice: "スポット「#{@spot.name_ja}」を登録しました"
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @spot.update(spot_params)
      redirect_to admin_spots_path, notice: "スポット「#{@spot.name_ja}」を更新しました"
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    if @spot.destroy
      redirect_to admin_spots_path, notice: "スポット「#{@spot.name_ja}」を削除しました", status: :see_other
    else
      redirect_to admin_spots_path, alert: "スポット「#{@spot.name_ja}」を削除できませんでした", status: :see_other
    end
  rescue ActiveRecord::InvalidForeignKey
    redirect_to admin_spots_path, alert: "スポット「#{@spot.name_ja}」には訪問の記録があるため削除できません", status: :see_other
  end

  private

  def set_spot
    @spot = Spot.find(params[:id])
  end

  def spot_params
    params.expect(spot: [:name_ja, :name_en, :category, :description_en, :access, :latitude, :longitude, :image])
  end
end
