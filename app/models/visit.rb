class Visit < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :spot

  enum :status, { want_to_go: 0, visited: 1 }, validate: true

  validates :user_id, presence: true, uniqueness: { scope: :spot_id }
end
