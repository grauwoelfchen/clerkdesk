require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  locker_room_fixtures(:teams, :users, :mateships)
  fixtures(:contacts)

  def test_validation_without_slug
    contact = Contact.new(:slug => '')
    refute(contact.valid?)
    message = 'can\'t be blank'
    assert_equal([message], contact.errors[:slug])
  end

  def test_validation_error_with_duplicated_slug
    existing_user = contacts(:oswald_contact)
    contact = Contact.new(:slug => existing_user.slug)
    refute(contact.valid?)
    message = 'has already been taken'
    assert_equal([message], contact.errors[:slug])
  end

  def test_validation_error_with_too_long_slug
    contact = Contact.new(:slug => 'long' * 49)
    refute(contact.valid?)
    message = 'is too long (maximum is 192 characters)'
    assert_equal([message], contact.errors[:slug])
  end

  def test_validation_error_with_invalid_slug
    contact = Contact.new(:slug => '~/.ssh')
    refute(contact.valid?)
    message = 'is invalid'
    assert_equal([message], contact.errors[:slug])
  end

  def test_validation_error_with_too_long_property
    contact = Contact.new(:property => 'long' * 49)
    refute(contact.valid?)
    message = 'is too long (maximum is 192 characters)'
    assert_equal([message], contact.errors[:property])
  end

  def test_validation_error_without_name
    contact = Contact.new(:name => nil)
    refute(contact.valid?)
    message = 'can\'t be blank'
    assert_equal([message], contact.errors[:name])
  end

  def test_validation_error_with_too_long_name
    contact = Contact.new(:name => 'long' * 33)
    refute(contact.valid?)
    message = 'is too long (maximum is 128 characters)'
    assert_equal([message], contact.errors[:name])
  end

  def test_validation_error_with_invalid_country
    contact = Contact.new(:country => 'space')
    refute(contact.valid?)
    message = 'is not included in the list'
    assert_equal([message], contact.errors[:country])
  end

  def test_allowance_without_country
    contact = Contact.new(:country => '')
    refute(contact.valid?)
    assert_empty(contact.errors[:country])
  end

  def test_validation_error_with_orphaned_division
    contact = Contact.new(:country => nil, :division => '01')
    refute(contact.valid?)
    message = 'is not included in the list'
    assert_equal([message], contact.errors[:division])
  end

  def test_validation_error_with_invalid_division
    contact = Contact.new(:country => 'JP', :division => '48')
    refute(contact.valid?)
    message = 'is not included in the list'
    assert_equal([message], contact.errors[:division])
  end

  def test_validation_error_with_too_long_city
    contact = Contact.new(:city => 'long' * 17)
    refute(contact.valid?)
    message = 'is too long (maximum is 64 characters)'
    assert_equal([message], contact.errors[:city])
  end

  def test_validation_error_with_too_long_address
    contact = Contact.new(:address => 'long' * 64)
    refute(contact.valid?)
    message = 'is too long (maximum is 255 characters)'
    assert_equal([message], contact.errors[:address])
  end

  def test_validation_error_with_invalid_postcode
    contact = Contact.new(:postcode => ':-)')
    refute(contact.valid?)
    message = 'is invalid'
    assert_equal([message], contact.errors[:postcode])
  end

  def test_validation_error_with_too_long_postcode
    contact = Contact.new(:postcode => '0' * 33)
    refute(contact.valid?)
    message = 'is too long (maximum is 32 characters)'
    assert_equal([message], contact.errors[:postcode])
  end

  def test_allowance_without_postcode
    contact = Contact.new(:postcode => '')
    refute(contact.valid?)
    assert_empty(contact.errors[:postcode])
  end

  def test_validation_error_with_invalid_phone
    contact = Contact.new(:phone => 'abcdefg')
    refute(contact.valid?)
    message = 'is invalid'
    assert_equal([message], contact.errors[:phone])
  end

  def test_validation_error_with_too_long_phone
    contact = Contact.new(:phone => '+81-1234-5678-9012-3456-78')
    refute(contact.valid?)
    message = 'is too long (maximum is 24 characters)'
    assert_equal([message], contact.errors[:phone])
  end

  def test_allowance_without_phone
    contact = Contact.new(:phone => '')
    refute(contact.valid?)
    assert_empty(contact.errors[:phone])
  end

  def test_validation_error_with_invalid_email
    contact = Contact.new(:email => 'ohmygosh#example,org')
    refute(contact.valid?)
    message = 'is invalid'
    assert_equal([message], contact.errors[:email])
  end

  def test_validation_error_with_too_long_email
    contact = Contact.new(:email => 'long' * 14 + '@example.org')
    refute(contact.valid?)
    message = 'is too long (maximum is 64 characters)'
    assert_equal([message], contact.errors[:email])
  end

  def test_allowance_without_email
    contact = Contact.new(:email => '')
    refute(contact.valid?)
    assert_empty(contact.errors[:email])
  end

  def test_validation_error_with_too_long_memo
    contact = Contact.new(:memo => 'long' * 64)
    refute(contact.valid?)
    message = 'is too long (maximum is 255 characters)'
    assert_equal([message], contact.errors[:memo])
  end
end
