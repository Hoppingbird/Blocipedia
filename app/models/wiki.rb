class Wiki < ActiveRecord::Base
  belongs_to :user

  has_many :collaborators
  has_many :users, through: :collaborators

  default_scope { order('created_at DESC')}

  scope :visible_to, ->(user, viewable = true) {user ? all : where(public: viewable)}

  # Visible where in the wiki table public = true and where in the wiki table user owns the record
  #scope :visible_to, ->(user) {
    #where(
        #Wiki.arel_table[:public].eq(true).or(Wiki.arel_table[:user_id].eq(user.id))
    #)
  #}
end
