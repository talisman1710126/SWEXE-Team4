require "test_helper"

class Public::SpotsControllerTest < ActionDispatch::IntegrationTest
  test "root lists registered spots" do
    get root_path

    assert_response :success
    assert_select ".spot-card", count: 2
  end

  test "filters spots by category" do
    spots(:one).update!(category: :dam)

    get public_spots_path(category: "dam")

    assert_response :success
    assert_select ".spot-card", count: 1
    assert_select ".spot-card h2", text: "MyString"
  end

  test "sorts spots by distance when valid coordinates are provided" do
    nearest = spots(:one)
    farther = spots(:two)
    nearest.update!(latitude: 34.0, longitude: -118.0)
    farther.update!(latitude: 35.0, longitude: -119.0)

    get public_spots_path(latitude: 34.01, longitude: -118.01)

    assert_response :success
    assert_select ".spot-card" do |cards|
      assert_equal [ nearest.id.to_s, farther.id.to_s ], cards.map { |card| card["data-spot-id"] }
    end
  end

  test "shows spot details and an embedded map" do
    get public_spot_path(spots(:one))

    assert_response :success
    assert_select "h1", text: "MyString"
    assert_select "iframe[title='Map showing MyString']"
    assert_select "a[href*='google.com/maps/search']"
  end

  test "shows an uploaded spot image" do
    spot = spots(:one)
    spot.image.attach(io: StringIO.new("sample image"), filename: "spot.jpg", content_type: "image/jpeg")

    get public_spot_path(spot)

    assert_response :success
    assert_select "img.detail-image[alt='MyString']"
  end

  test "rejects invalid coordinates" do
    get public_spots_path(latitude: 100, longitude: 0)

    assert_response :bad_request
  end
end
