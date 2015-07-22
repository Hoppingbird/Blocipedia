class Wiki < ActiveRecord::Base
  belongs_to :user
  ##has_many :collaborators
  scope :visible_to, ->(user) {
    where(
        Wiki.arel_table[:public].eq(true).or(Wiki.arel_table[:user_id].eq(user.id))
    )
  }
end
