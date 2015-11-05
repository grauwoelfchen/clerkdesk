module Finance
  module EntriesHelper
    def account_book_entry_contact_labels(entry)
      if entry.persisted?
        entry.contacts.map(&:label)
      else
        entry.involvements.inject([]) { |acc, involvement|
          acc << involvement.holder if involvement.holder_type == 'Contact'
        }.map(&:label)
      end
    end
  end
end
