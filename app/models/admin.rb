class Admin < ApplicationRecord
  before_destroy :ensure_an_admin_is_one_or_more
  belongs_to :user

  private

  def ensure_an_admin_is_one_or_more
    throw(:abort) if Admin.count == 1 && self.user_id.present?
  end
end
