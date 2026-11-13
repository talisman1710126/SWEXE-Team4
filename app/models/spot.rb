class Spot < ApplicationRecord
  enum :category, { dam: 0, bridge: 1, tunnel: 2, port: 3, other: 4 }, validate: true

  CATEGORY_LABELS = { "dam" => "ダム", "bridge" => "橋", "tunnel" => "トンネル", "port" => "港湾", "other" => "その他" }.freeze

  validates :name_ja, :name_en, :category, :latitude, :longitude, presence: true
  validates :latitude,  numericality: { greater_than_or_equal_to: -90,  less_than_or_equal_to: 90 },  allow_nil: true
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }, allow_nil: true
end
