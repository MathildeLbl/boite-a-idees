class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :idea
  validates :value, inclusion: { in: [ -1, 1 ] }
end
