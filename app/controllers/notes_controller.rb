class NotesController < ApplicationController
  before_action :load_note, :only => [:show, :edit, :update, :destroy]

  def index
    @notes = Note.scoped_to(current_account)
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    @note.assign_attributes(:account_id => current_account.id)
    if @note.save
      redirect_to @note, :notice => "Note is cuccessfully created."
    else
      flash.now[:alert] = "Note could not be created."
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @note.update_attributes(note_params)
      redirect_to @note, :notice => "Note is Successfully updated."
    else
      flash.now[:alert] = "Note could not be updated."
      render :edit
    end
  end

  def destroy
  end

  private

  def load_note
    @note = Note.scoped_to(current_account).find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :content)
  end
end
