class NotesController < ApplicationController
  def index
    @notes = Note.scoped_to(current_account)
  end
end
