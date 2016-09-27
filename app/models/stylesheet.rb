class Stylesheet < ApplicationRecord
  belongs_to :user
  validates_presence_of :url

  scope :from_user, -> (user) { where(user_id: user.id) }
end
