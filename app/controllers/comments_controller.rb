class CommentsController < ApplicationController
  before_action :set_idea, only: [:create]
  before_action :set_comment, only: [:destroy]

  def create
    @comment = @idea.comments.build(comment_params)
    @comment.user = current_user
    authorize @comment

    if @comment.save
      redirect_to idea_path(@idea), notice: "Commentaire ajouté."
    else
      redirect_to idea_path(@idea), alert: @comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    authorize @comment
    @comment.destroy
    redirect_to idea_path(@comment.idea), notice: "Commentaire supprimé."
  end

  private

  def set_idea
    @idea = Idea.find(params[:idea_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
