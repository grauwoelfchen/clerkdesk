crumb :root do
  link "Desktop", root_path
end

crumb :notes do
  link "Notes", notes_path
end

crumb :note do |note|
  unless note.persisted?
    link "New", nil
  else
    link note.title, note
  end
  parent :notes
end

crumb :accounts do
  link "Accounts", accounts_path
end

crumb :account do |account|
  unless account.persisted?
    link "New", nil
  else
    link account.name, account
  end
  parent :accounts
end

crumb :ledgers do |account|
  link "Ledgers", account_ledgers_path(account)
  parent :account, account
end

crumb :budget do |account|
  link "Budget", account_budget_path(account)
  parent :account, account
end

crumb :settlement do |account|
  link "Settlement", account_settlement_path(account)
  parent :account, account
end
