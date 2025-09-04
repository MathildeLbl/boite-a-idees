class Idea < ApplicationRecord
  belongs_to :user
  has_many :votes
  has_many :comments
  has_many :idea_tags, dependent: :destroy
  has_many :tags, through: :idea_tags
  has_many :comments, dependent: :destroy

  validates :title, :description, presence: true

  attr_accessor :tags_text

  def tags_text
    @tags_text.presence || tags.order(:name).pluck(:name).join(", ")
  end

  def sync_tags_from_text
    names = (tags_text || "")
              .split(",")
              .map { |n| n.strip.downcase }
              .reject(&:blank?)
              .uniq

    self.tags = names.map { |name| Tag.find_or_create_by!(name: name) }
  end

  def self.search_by_tag(query)
    return all if query.blank?

    joins(:tags).where("tags.name ILIKE ?", "%#{query}%").distinct
  end
end
