require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  locker_room_fixtures(:teams, :users, :mateships)
  fixtures(:notes)

  def setup
    Note.public_activity_off
  end

  def teardown
    Note.public_activity_on
  end

  def test_validation_with_without_title
    note = Note.new(:title => nil)
    refute(note.valid?)
    message = "can't be blank"
    assert_equal([message], note.errors[:title])
  end

  def test_validation_with_too_long_title
    note = Note.new(:title => 'long' * 50)
    refute(note.valid?)
    message = 'is too long (maximum is 192 characters)'
    assert_equal([message], note.errors[:title])
  end

  def test_validation_with_duplicated_title
    other_note = notes(:favorite_song)
    note = Note.new(:title => other_note.title)
    refute(note.valid?)
    message = 'has already been taken'
    assert_equal([message], note.errors[:title])
  end

  def test_validation_with_too_long_content
    note = Note.new(:content => 'long' * 1025)
    refute(note.valid?)
    message = 'is too long (maximum is 4096 characters)'
    assert_equal([message], note.errors[:content])
  end

  def test_html_conversion_after_save
    attrs = {
      :title   => 'test',
      :content => <<-CONTENT
# Heading

* list1
* list2
* list3
    CONTENT
    }
    note = Note.new(attrs)
    assert_nil(note.content_html)
    assert(note.save)
    expected_html = <<-HTML
<h1>Heading</h1>

<ul>
<li>list1</li>
<li>list2</li>
<li>list3</li>
</ul>
    HTML
    assert_equal(expected_html, note.content_html)
  end

  def test_tag_creation
    example_tag = 'example'
    attrs = {
      :title    => 'Test',
      :tag_list => [example_tag]
    }
    note = Note.new(attrs)
    note.save
    tag = Note.tags_on(:tags).find_by!(name: example_tag)
    assert_equal(tag.name, example_tag)
  end
end
