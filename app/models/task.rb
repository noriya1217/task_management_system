class Task < ApplicationRecord
  validates :subject, presence: true
  validates :content, presence: true

  scope :sort_expired, -> { order(expired_at: :desc) }
  scope :latest, -> { order(created_at: :desc) }
  scope :search_ransack, -> (parameter){ ransack(parameter) }
end
