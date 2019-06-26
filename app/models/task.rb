class Task < ApplicationRecord
  belongs_to :user

  validates :subject, presence: true
  validates :content, presence: true

  enum priority:[:high, :middle, :low]
  paginates_per 10

  scope :sort_expired, -> (parameter){ order(expired_at: :desc).page(parameter)  }
  scope :sort_priority, -> (parameter){ order(priority: :asc).page(parameter)  }
  scope :latest, -> (parameter){ order(created_at: :desc).page(parameter) }
  scope :search_ransack, -> (parameter){ ransack(parameter) }
end
