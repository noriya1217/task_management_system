class Task < ApplicationRecord
  belongs_to :user
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings
  has_many :user_labelings, dependent: :destroy
  has_many :user_labels, through: :user_labelings

  validates :subject, presence: true
  validates :content, presence: true

  enum priority:[:high, :middle, :low]
  paginates_per 10

  scope :sorted_by, -> (_sort_key, _page) do
    if _sort_key == 'expired_at'
      order(expired_at: :desc).page(_page)
    elsif _sort_key == 'priority'
      order(priority: :asc).page(_page)
    end
  end

  scope :latest, -> (_page){ order(created_at: :desc).page(_page) }
  scope :search_ransack, -> (_page){ ransack(_page) }
  scope :user_task_list, -> (user_id){ where(user_id: user_id).order(created_at: :desc) }
end
