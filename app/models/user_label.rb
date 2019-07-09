class UserLabel < ApplicationRecord
  belongs_to :user
  has_many :user_labelings, dependent: :destroy

  # TODO: 同じ処理をlabel.rbでも行っている。共通化する
  validates :name, presence: true, length: { in: 1..20 }
  scope :latest, -> { order(created_at: :asc) }
end
