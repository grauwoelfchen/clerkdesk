crumb :root do
  link t("crumb.desktop"), root_path
end

# notes

crumb :notes do
  link Note.model_name.human.pluralize, notes_path
end

crumb :notes_with_tag  do |tag|
  link t("crumb.tag", tag: truncate(tag, length: 8)), nil
  parent :notes
end

crumb :note do |note|
  unless note.persisted?
    link t("crumb.new"), nil
  else
    link truncate(note.title, length: 27), note
  end
  parent :notes
end

# finance

crumb :'finance/reports' do
  link Finance::Report.model_name.human.pluralize, finance_reports_path
end

crumb :'finance/report' do |report|
  unless report.persisted?
    link t("crumb.new"), nil
  else
    link report.name, [:overview, :finance, report]
  end
  parent :'finance/reports'
end

crumb :'finance/categories' do |report|
  link Finance::Category.model_name.human.pluralize, finance_report_categories_path(report)
  parent :'finance/report', report
end

crumb :'finance/category' do |report, category|
  unless category.persisted?
    link t("crumb.new"), nil
  else
    link category.name, finance_report_category_path(report, category)
  end
  parent :'finance/categories', report
end

crumb :'finance/account_books' do |report|
  link Finance::AccountBook.model_name.human.pluralize, finance_report_account_books_path(report)
  parent :'finance/report', report
end

crumb :'finance/account_book' do |report, account_book|
  unless account_book.persisted?
    link t("crumb.new"), nil
  else
    link account_book.name, finance_report_account_book_path(report, account_book)
  end
  parent :'finance/account_books', report
end

crumb :'finance/entries' do |report, account_book|
  link Finance::Entry.model_name.human.pluralize, finance_report_account_book_entries_path(report, account_book)
  parent :'finance/account_book', report, account_book
end

crumb :'finance/entry' do |report, account_book, entry|
  unless entry.persisted?
    link t("crumb.new"), nil
  else
    link entry.title, finance_report_account_book_entry_path(report, account_book, entry)
  end
  parent :'finance/entries', report, account_book
end

crumb :'finance/budget' do |report|
  link Finance::Budget.model_name.human, finance_report_budget_path(report)
  parent :'finance/report', report
end

# people

crumb :people do
  link Person.model_name.human.pluralize, people_path
end

crumb :person do |person|
  unless person.persisted?
    link t("crumb.new"), nil
  else
    link person.name, person_path(person)
  end
  parent :people
end

# users

crumb :users do
  link LockerRoom::User.model_name.human.pluralize, users_path
end
