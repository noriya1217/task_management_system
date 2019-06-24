class Task < ApplicationRecord
  validates :subject, presence: true
  validates :content, presence: true

  enum priority:[:high, :middle, :low]

  scope :sort_expired, -> { order(expired_at: :desc) }
  scope :sort_priority, -> { order(priority: :asc) }
  scope :latest, -> { order(created_at: :desc) }
  scope :search_ransack, -> (parameter){ ransack(parameter) }
end
