class SnippetsController < WorkspaceController
  include PublicActivity::StoreController

  before_action :set_snippet, only: [:show, :edit, :update, :destroy]

  def index
    @snippets = Snippet.includes(:tags)
      .order_by(params[:field], params[:direction])
      .page(params[:page])
    if params[:t]
      @tag = Snippet.tags_on(:tags).find_by!(:name => params[:t])
      @snippets = @snippets.tagged_with(@tag.name)
    end
  end

  def new
    @snippet = Snippet.new
  end

  def create
    @snippet = Snippet.new(snippet_params)
    if @snippet.save
      redirect_to(@snippet, :notice => 'Snippet has been successfully created.')
    else
      flash.now[:alert] = 'Snippet could not be created.'
      render(:new)
    end
  end

  def show
  end

  def edit
  end

  def update
    if @snippet.update_attributes(snippet_params)
      redirect_to(@snippet, :notice => 'Snippet has been successfully updated.')
    else
      flash.now[:alert] = 'Snippet could not be updated.'
      render(:edit)
    end
  end

  def destroy
    @snippet.destroy
    redirect_to(snippets_url,
      :notice => 'Snippet has been successfully destroyed.')
  end

  private

  def set_snippet
    @snippet = Snippet.find(params[:id])
  end

  def snippet_params
    params.require(:snippet).permit(:title, :content, :tag_list)
  end
end
