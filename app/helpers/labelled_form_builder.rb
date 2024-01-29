class LabelledFormBuilder < CommonFormBuilder
  INPUT_FIELDS_TO_LABEL = %w[text_field date_field text_area].freeze

  INPUT_FIELDS_TO_LABEL.each do |input_field|
    define_method(input_field) do |attribute, options = {}|
      label(attribute) + @template.tag.br + super(attribute, options)
    end
  end
end