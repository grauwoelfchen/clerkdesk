require "test_helper"

class NoteTest < ActiveSupport::TestCase
  locker_room_fixtures(:teams, :users, :mateships)
  fixtures(:notes)

  def test_validation_with_without_title
    note = Note.new(:title => nil)
    refute(note.valid?)
    message = "can't be blank"
    assert_equal([message], note.errors[:title])
  end

  def test_validation_with_too_long_title
    note = Note.new(:title => "long" * 50)
    refute(note.valid?)
    message = "is too long (maximum is 192 characters)"
    assert_equal([message], note.errors[:title])
  end

  def test_validation_with_duplicated_title
    other_note = notes(:favorite_song)
    note = Note.new(:title => other_note.title)
    refute(note.valid?)
    message = "has already been taken"
    assert_equal([message], note.errors[:title])
  end
end
