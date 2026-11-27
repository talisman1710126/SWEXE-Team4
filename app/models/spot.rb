class Spot < ApplicationRecord
  ALLOWED_IMAGE_CONTENT_TYPES = %w[image/jpeg image/png image/webp].freeze
  MAX_IMAGE_SIZE = 5.megabytes

  # Registers coordinate columns for Geocoder queries; it does not geocode records automatically.
  geocoded_by :name_en, latitude: :latitude, longitude: :longitude

  has_one_attached :image
  has_many :visits, dependent: :restrict_with_error

  enum :category, { dam: 0, bridge: 1, tunnel: 2, port: 3, other: 4 }, validate: true

  CATEGORY_LABELS = { "dam" => "ダム", "bridge" => "橋", "tunnel" => "トンネル", "port" => "港湾", "other" => "その他" }.freeze

  validates :name_ja, :name_en, :category, :latitude, :longitude, presence: true
  validates :latitude,  numericality: { greater_than_or_equal_to: -90,  less_than_or_equal_to: 90 },  allow_nil: true
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }, allow_nil: true
  validate :validate_image

  def category_label
    CATEGORY_LABELS.fetch(category, "未分類")
  end

  private

  def validate_image
    return unless image.attached?

    unless ALLOWED_IMAGE_CONTENT_TYPES.include?(image.blob.content_type)
      errors.add(:image, "はJPEG、PNG、WebP形式のみアップロードできます")
    end

    if image.blob.byte_size > MAX_IMAGE_SIZE
      errors.add(:image, "は5MB以下のファイルを選択してください")
    end
  end
end
