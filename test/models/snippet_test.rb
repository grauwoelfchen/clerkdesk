require 'test_helper'

class SnippetTest < ActiveSupport::TestCase
  locker_room_fixtures(:teams, :users, :mateships)
  fixtures(:snippets)

  def setup
    Snippet.public_activity_off
  end

  def teardown
    Snippet.public_activity_on
  end

  def test_validation_with_without_title
    snippet = Snippet.new(:title => nil)
    refute(snippet.valid?)
    message = 'can\'t be blank'
    assert_equal([message], snippet.errors[:title])
  end

  def test_validation_with_too_long_title
    snippet = Snippet.new(:title => 'long' * 50)
    refute(snippet.valid?)
    message = 'is too long (maximum is 192 characters)'
    assert_equal([message], snippet.errors[:title])
  end

  def test_validation_with_duplicated_title
    other_snippet = snippets(:favorite_song)
    snippet = Snippet.new(:title => other_snippet.title)
    refute(snippet.valid?)
    message = 'has already been taken'
    assert_equal([message], snippet.errors[:title])
  end

  def test_validation_with_too_long_content
    snippet = Snippet.new(:content => 'long' * 1025)
    refute(snippet.valid?)
    message = 'is too long (maximum is 4096 characters)'
    assert_equal([message], snippet.errors[:content])
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
    snippet = Snippet.new(attrs)
    assert_nil(snippet.content_html)
    assert(snippet.save)
    expected_html = <<-HTML
<h1>Heading</h1>

<ul>
<li>list1</li>
<li>list2</li>
<li>list3</li>
</ul>
    HTML
    assert_equal(expected_html, snippet.content_html)
  end

  def test_tag_creation
    example_tag = 'example'
    attrs = {
      :title    => 'Test',
      :tag_list => [example_tag]
    }
    snippet = Snippet.new(attrs)
    snippet.save
    tag = Snippet.tags_on(:tags).find_by!(name: example_tag)
    assert_equal(tag.name, example_tag)
  end
end
