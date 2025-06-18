class Idea < ApplicationRecord
  belongs_to :user
  has_many :votes
  has_many :comments
  has_many :idea_tags
  has_many :tags, through: :idea_tags
end
