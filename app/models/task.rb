class Task < ApplicationRecord
  validates :subject, presence: true
  validates :content, presence: true
  # validates :expired_at, 

  def self.sort_expired
    order(expired_at: :desc)
  end

  def self.latest
    order(created_at: :desc)
  end
end
