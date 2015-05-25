crumb :root do
  link t("crumb.desktop"), root_path
end

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

crumb :finances do
  link Finance.model_name.human.pluralize, finances_path
end

crumb :finance do |finance|
  unless finance.persisted?
    link t("crumb.new"), nil
  else
    link finance.name, finance
  end
  parent :finances
end

crumb :finance_categories do |finance|
  link FinanceCategory.model_name.human.pluralize, finance_categories_path(finance)
  parent :finance, finance
end

crumb :finance_category do |finance, category|
  unless category.persisted?
    link t("crumb.new"), nil
  else
    link category.name, finance_category_path(finance, category)
  end
  parent :finance_categories, finance
end

crumb :ledger do |finance|
  link Ledger.model_name.human, finance_ledger_path(finance)
  parent :finance, finance
end

crumb :ledger_entry do |finance, entry|
  unless entry.persisted?
    link t("crumb.new"), nil
  else
    link entry.title, finance_ledger_entry_path(finance, entry)
  end
  parent :ledger, finance
end

crumb :budget do |finance|
  link Budget.model_name.human, finance_budget_path(finance)
  parent :finance, finance
end

crumb :settlement do |finance|
  link Settlement.model_name.human, finance_settlement_path(finance)
  parent :finance, finance
end
