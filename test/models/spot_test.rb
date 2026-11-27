require "test_helper"
require "base64"

class SpotTest < ActiveSupport::TestCase
  VALID_PNG = Base64.decode64("iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+jXioAAAAASUVORK5CYII=")

  test "accepts supported image types within the size limit" do
    spot = build_spot_with_image(VALID_PNG, "spot.png", "image/png")

    assert spot.valid?, spot.errors.full_messages.join(", ")
  end

  test "rejects unsupported image content types" do
    spot = build_spot_with_image("%PDF-1.4\n", "document.pdf", "application/pdf")

    assert_not spot.valid?
    assert_includes spot.errors[:image], "はJPEG、PNG、WebP形式のみアップロードできます"
  end

  test "rejects images larger than five megabytes" do
    image = VALID_PNG + ("x" * (Spot::MAX_IMAGE_SIZE + 1 - VALID_PNG.bytesize))
    spot = build_spot_with_image(image, "large.png", "image/png")

    assert_not spot.valid?
    assert_includes spot.errors[:image], "は5MB以下のファイルを選択してください"
  end

  private

  def build_spot_with_image(contents, filename, content_type)
    spot = spots(:one).dup
    spot.image.attach(io: StringIO.new(contents), filename: filename, content_type: content_type)
    spot
  end
end
