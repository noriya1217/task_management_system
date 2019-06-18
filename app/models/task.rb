class Task < ApplicationRecord
  validates :subject, presence: true
  validates :content, presence: true

  def self.latest
    order(created_at: :desc)
  end
end
