class IdeasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_idea, only: [:show, :edit, :update, :destroy]
  before_action :authorize_idea, only: [:edit, :update, :destroy]

  def index
    @ideas = policy_scope(Idea.all)
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

    if @idea.save
      redirect_to @idea, notice: "Idée créée avec succès !"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @idea.update(idea_params)
      redirect_to @idea, notice: "Idée mise à jour."
    else
      render :edit
    end
  end

  def destroy
    @idea = Idea.find(params[:id])
    authorize @idea  # Pundit vérifie si l'utilisateur peut supprimer
    @idea.destroy
    redirect_to ideas_path, notice: "Idée supprimée avec succès."
  end

  private

  def set_idea
    @idea = Idea.find(params[:id])
  end

  def authorize_idea
    authorize @idea
  end

  def idea_params
    params.require(:idea).permit(:title, :description)
  end
end
