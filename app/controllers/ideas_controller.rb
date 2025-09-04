class IdeasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_idea, only: [:show, :edit, :update, :destroy]
  before_action :authorize_idea, only: [:edit, :update, :destroy]

  def index
    if params[:tag].present?
      @current_tag = Tag.find_by(name: params[:tag].downcase)
      @ideas = @current_tag ? policy_scope(@current_tag.ideas) : Idea.none
    else
      @ideas = policy_scope(Idea.all)
    end
  end

  def show
  end

  def new
    @idea = current_user.ideas.build
    authorize @idea
  end

  def create
    @idea = current_user.ideas.build(idea_params)
    authorize @idea
    @idea.sync_tags_from_text

    if @idea.save
      redirect_to @idea, notice: "Idée créée avec succès !"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    @idea.assign_attributes(idea_params)
    @idea.sync_tags_from_text

    if @idea.save
      redirect_to @idea, notice: "Idée mise à jour."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @idea
    @idea.destroy
    redirect_to ideas_path, notice: "Idée supprimée avec succès."
  end

  def index
  @ideas = policy_scope(Idea.all)

  if params[:q].present?
    @ideas = @ideas.search_by_tag(params[:q])
  end

  @ideas = @ideas.order(created_at: :desc)
  end

  private

  def set_idea
    @idea = Idea.find(params[:id])
  end

  def authorize_idea
    authorize @idea
  end

  def idea_params
    params.require(:idea).permit(:title, :description, :tags_text)
  end
end
