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

crumb :finances do
  link "finances", finances_path
end

crumb :finance do |finance|
  unless finance.persisted?
    link "New", nil
  else
    link finance.name, finance
  end
  parent :finances
end

crumb :ledger do |finance|
  link "Ledger", finance_ledger_path(finance)
  parent :finance, finance
end

crumb :budget do |finance|
  link "Budget", finance_budget_path(finance)
  parent :finance, finance
end

crumb :settlement do |finance|
  link "Settlement", finance_settlement_path(finance)
  parent :finance, finance
end
