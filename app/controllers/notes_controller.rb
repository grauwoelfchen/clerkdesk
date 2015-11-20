class NotesController < WorkspaceController
  include PublicActivity::StoreController

  before_action :set_note, only: [:show, :edit, :update, :destroy]

  def index
    @notes = Note.includes(:tags)
      .order_by(params[:field], params[:direction])
      .page(params[:page])
    if params[:tag]
      @tag = Note.tags_on(:tags).find_by!(:name => params[:tag])
      @notes = @notes.tagged_with(@tag.name)
    end
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      redirect_to(@note, :notice => 'Note has been successfully created.')
    else
      flash.now[:alert] = 'Note could not be created.'
      render(:new)
    end
  end

  def show
  end

  def edit
  end

  def update
    if @note.update_attributes(note_params)
      redirect_to(@note, :notice => 'Note has been successfully updated.')
    else
      flash.now[:alert] = 'Note could not be updated.'
      render(:edit)
    end
  end

  def destroy
    @note.destroy
    redirect_to(notes_url,
      :notice => 'Note has been successfully destroyed.')
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :content, :tag_list)
  end
end
