class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :idea

  validates :body, presence: true, length: { minimum: 2, maximum: 2000 }
end
