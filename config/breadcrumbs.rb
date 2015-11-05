crumb :root do
  link t('crumb.desktop'), root_path
end

# notes

crumb :notes do
  link Note.model_name.human.pluralize, notes_path
end

crumb :notes_with_tag  do |tag|
  link t('crumb.tag', tag: truncate(tag, length: 8)), nil
  parent :notes
end

crumb :note do |note|
  unless note.persisted?
    link t('crumb.new'), nil
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
    link t('crumb.new'), nil
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
    link t('crumb.new'), nil
  else
    link category.name, finance_report_category_path(report, category)
  end
  parent :'finance/categories', report
end

crumb :'finance/accounts' do |report|
  link Finance::Account.model_name.human.pluralize, finance_report_accounts_path(report)
  parent :'finance/report', report
end

crumb :'finance/account' do |report, account|
  unless account.persisted?
    link t('crumb.new'), nil
  else
    link account.name, finance_report_account_path(report, account)
  end
  parent :'finance/accounts', report
end

crumb :'finance/entries' do |report, account|
  link Finance::Entry.model_name.human.pluralize, finance_report_account_entries_path(report, account)
  parent :'finance/account', report, account
end

crumb :'finance/entry' do |report, account, entry|
  unless entry.persisted?
    link t('crumb.new'), nil
  else
    link entry.title, finance_report_account_entry_path(report, account, entry)
  end
  parent :'finance/entries', report, account
end

crumb :'finance/budget' do |report|
  link Finance::Budget.model_name.human, finance_report_budget_path(report)
  parent :'finance/report', report
end

# contacts

crumb :contacts do
  link Contact.model_name.human.pluralize, contacts_path
end

crumb :contact do |contact|
  unless contact.persisted?
    link t('crumb.new'), nil
  else
    link contact.name, contact_path(contact)
  end
  parent :contacts
end

# users

crumb :users do
  link LockerRoom::User.model_name.human.pluralize, users_path
end

crumb :user do |user|
  unless user.persisted?
    link t('crumb.new'), nil
  else
    link user.username, user_path(user)
  end
  parent :users
end
