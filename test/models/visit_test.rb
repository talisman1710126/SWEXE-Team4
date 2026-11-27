require "test_helper"

class VisitTest < ActiveSupport::TestCase
  test "allows a user id before the User model exists" do
    visit = Visit.new(user_id: 1, spot: spots(:one))

    assert_predicate visit, :valid?
    assert_equal "want_to_go", visit.status
  end

  test "validates the status and unique user-spot pair" do
    visit = Visit.create!(user_id: 1, spot: spots(:one), status: :want_to_go)
    duplicate = Visit.new(user_id: visit.user_id, spot: visit.spot, status: :visited)

    assert_not duplicate.valid?
    assert duplicate.errors.of_kind?(:user_id, :taken)
    assert_not Visit.new(user_id: 2, spot: spots(:two), status: 2).valid?
  end
end
