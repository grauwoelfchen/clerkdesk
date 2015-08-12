module Finance
  module EntriesHelper
    def account_book_entry_people_labels(entry)
      if entry.persisted?
        entry.people.map(&:label)
      else
        entry.involvements.inject([]) { |acc, involvement|
          acc << involvement.holder if involvement.holder_type == 'Person'
        }.map(&:label)
      end
    end
  end
end
