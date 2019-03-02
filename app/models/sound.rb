class Sound < ApplicationRecord
  belongs_to :user

  # default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :path, presence: true, length: { maximum: 4096 }
  validates :name, presence: true, length: { maximum: 255 }
end
