class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :feed
  attr_accessible :user_id, :body

  validates_presence_of :body
end
