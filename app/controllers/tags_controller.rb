class TagsController < ApplicationController
  def index
    @tags = Tag.order(:name)
  end

  def show
    @tag = Tag.find(params[:id])
    @ideas = @tag.ideas.includes(:user, :tags).order(created_at: :desc)
  end
end

