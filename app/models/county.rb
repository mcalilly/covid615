class County < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :state
  has_many :updates
end
