class Task < ApplicationRecord
  validates :subject, presence: true
  validates :content, presence: true
  
  enum state: { task_not_running: 0, task_running: 1, task_done: 2 }

  def self.sort_expired
    order(expired_at: :desc)
  end

  def self.latest
    order(created_at: :desc)
  end
end
