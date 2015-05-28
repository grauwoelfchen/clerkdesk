require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  locker_room_fixtures(:accounts, :members, :users)
  fixtures(:people)

  def test_validation_duplicated_slug
    existing_user = people(:oswald_as_person)
    person = Person.new(:slug => existing_user.slug)
    refute(person.valid?)
    message = "has already been taken"
    assert_equal([message], person.errors[:slug])
  end

  def test_validation_with_too_long_slug
    person = Person.new(:slug => 'long' * 49)
    refute(person.valid?)
    message = "is too long (maximum is 192 characters)"
    assert_equal([message], person.errors[:slug])
  end

  def test_validation_with_invalid_slug
    person = Person.new(:slug => "~/.ssh")
    refute(person.valid?)
    message = "is invalid"
    assert_equal([message], person.errors[:slug])
  end

  def test_validation_with_invalid_slug
    person = Person.new(:slug => "~/.ssh")
    refute(person.valid?)
    message = "is invalid"
    assert_equal([message], person.errors[:slug])
  end

  def test_validation_with_too_long_property
    person = Person.new(:property => "long" * 49)
    refute(person.valid?)
    message = "is too long (maximum is 192 characters)"
    assert_equal([message], person.errors[:property])
  end

  def test_validation_without_first_name
    person = Person.new(:first_name => nil)
    refute(person.valid?)
    message = "can't be blank"
    assert_equal([message], person.errors[:first_name])
  end

  def test_validation_with_too_long_first_name
    person = Person.new(:first_name => "long" * 33)
    refute(person.valid?)
    message = "is too long (maximum is 128 characters)"
    assert_equal([message], person.errors[:first_name])
  end

  def test_validation_without_last_name
    person = Person.new(:last_name => nil)
    refute(person.valid?)
    message = "can't be blank"
    assert_equal([message], person.errors[:last_name])
  end

  def test_validation_with_too_long_last_name
    person = Person.new(:last_name => "long" * 33)
    refute(person.valid?)
    message = "is too long (maximum is 128 characters)"
    assert_equal([message], person.errors[:last_name])
  end

  def test_validation_with_invalid_country
    person = Person.new(:country => "space")
    refute(person.valid?)
    message = "is not included in the list"
    assert_equal([message], person.errors[:country])
  end

  def test_validation_with_orphaned_state
    person = Person.new(:country => nil, :state => "01")
    refute(person.valid?)
    message = "is not included in the list"
    assert_equal([message], person.errors[:state])
  end

  def test_validation_with_invalid_state
    person = Person.new(:country => "JP", :state => "48")
    refute(person.valid?)
    message = "is not included in the list"
    assert_equal([message], person.errors[:state])
  end
end
