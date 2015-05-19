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
  link "Finances", finances_path
end

crumb :finance do |finance|
  unless finance.persisted?
    link "New", nil
  else
    link finance.name, finance
  end
  parent :finances
end

crumb :finance_categories do |finance|
  link "Categories", finance_categories_path(finance)
  parent :finance, finance
end

crumb :finance_category do |finance, category|
  unless category.persisted?
    link "New", nil
  else
    link category.name, finance_category_path(finance, category)
  end
  parent :finance_categories, finance
end

crumb :ledger do |finance|
  link "Ledger", finance_ledger_path(finance)
  parent :finance, finance
end

crumb :ledger_entry do |finance, entry|
  unless entry.persisted?
    link "Entry", nil
  else
    link "Entry", finance_ledger_entry_path(finance, entry)
  end
  parent :ledger, finance
end

crumb :budget do |finance|
  link "Budget", finance_budget_path(finance)
  parent :finance, finance
end

crumb :settlement do |finance|
  link "Settlement", finance_settlement_path(finance)
  parent :finance, finance
end
