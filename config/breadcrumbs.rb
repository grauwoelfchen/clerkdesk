crumb :root do
  link t('crumb.desktop'), root_path
end

# finance

crumb :'finance/ledgers' do
  link Finance::Ledger.model_name.human.pluralize, finance_ledgers_path
end

crumb :'finance/ledger' do |ledger|
  unless ledger.persisted?
    link t('crumb.new'), nil
  else
    link ledger.name, [:overview, :finance, ledger]
  end
  parent :'finance/ledgers'
end

crumb :'finance/categories' do |ledger|
  link Finance::Category.model_name.human.pluralize, finance_ledger_categories_path(ledger)
  parent :'finance/ledger', ledger
end

crumb :'finance/category' do |ledger, category|
  unless category.persisted?
    link t('crumb.new'), nil
  else
    link category.name, finance_ledger_category_path(ledger, category)
  end
  parent :'finance/categories', ledger
end

crumb :'finance/accounts' do |ledger|
  link Finance::Account.model_name.human.pluralize, finance_ledger_accounts_path(ledger)
  parent :'finance/ledger', ledger
end

crumb :'finance/account' do |ledger, account|
  unless account.persisted?
    link t('crumb.new'), nil
  else
    link account.name, finance_ledger_account_path(ledger, account)
  end
  parent :'finance/accounts', ledger
end

crumb :'finance/entries' do |ledger, account, category|
  link Finance::Entry.model_name.human.pluralize, finance_ledger_account_entries_path(ledger, account)
  if category
    link category.name, finance_ledger_category_path(ledger, category)
  end
  parent :'finance/account', ledger, account
end

crumb :'finance/entry' do |ledger, account, entry|
  unless entry.persisted?
    link t('crumb.new'), nil
  else
    link entry.title, finance_ledger_account_entry_path(ledger, account, entry)
  end
  parent :'finance/entries', ledger, account
end

crumb :'finance/budget' do |ledger|
  link Finance::Budget.model_name.human, finance_ledger_budget_path(ledger)
  parent :'finance/ledger', ledger
end

# snippets

crumb :snippets do
  link Snippet.model_name.human.pluralize, snippets_path
end

crumb :snippets_with_tag  do |tag|
  link t('crumb.tag', tag: truncate(tag, length: 8)), nil
  parent :snippets
end

crumb :snippet do |snippet|
  unless snippet.persisted?
    link t('crumb.new'), nil
  else
    link truncate(snippet.title, length: 27), snippet
  end
  parent :snippets
end

# contacts

crumb :contacts do
  link Contact.model_name.human.pluralize, contacts_path
end

crumb :contacts_with_tag  do |tag|
  link t('crumb.tag', tag: truncate(tag, length: 8)), nil
  parent :contacts
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

# settings

crumb :'settings/user' do
  link t('nav.settings'), user_settings_path
end

crumb :'settings/password' do
  link t('nav.settings'), edit_password_path
end
