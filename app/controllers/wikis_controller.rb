class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = current_user.wikis.create(wiki_params)
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:error] = "There was an error creating your wiki."
      redirect_to :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki was successfully updated."
      redirect_to @wiki
    else
      flash[:error] = "There was an error editing the post. Please try again."
      redirect_to :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    if @wiki.destroy
      flash[:notice] = "Successfully deleted your Wiki."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting your Wiki. Please try again."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :public)
  end
end