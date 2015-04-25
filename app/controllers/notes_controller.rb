class NotesController < ApplicationController
  def index
    @notes = Note.scoped_to(current_account)
  end

  def show
    @note = Note.scoped_to(current_account).find(params[:id])
  end
end
