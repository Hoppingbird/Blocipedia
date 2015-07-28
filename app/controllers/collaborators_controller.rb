class CollaboratorsController < ApplicationController
  def new
    @collaborator = Collaborator.new
    @users = User.all
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new(wiki_id: params[:wiki_id], user_id: params[:user_id])

    if @collaborator.save
      flash[:notice] = "Collaborator was added."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "There was an error saving your collaborator. Please try again."
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @collaborator.find_by(:user_id)

    if @collaborator.destroy
      flash[:notice] = "Collaborator was deleted."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "Item couldn't be deleted. Try again."
    end
  end

  def edit
    @users = User.all
  end

  private

  def collaborator_params
    params.require(:collaborators).permit(:wiki_id, :user_id)
  end
end

