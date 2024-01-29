module ArticlesHelper
  CREATE_NEW_ARTICLE_FIELDS = [
    { attribute: :title, input_field: :text_field },
    { attribute: :author, input_field: :text_field },
    { attribute: :date, input_field: :date_field },
    { attribute: :content, input_field: :text_area }
  ] 
end
