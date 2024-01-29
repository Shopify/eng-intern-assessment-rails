class LabelledFormBuilder < CommonFormBuilder
  INPUT_FIELDS_TO_LABEL = %w[text_field date_field text_area].freeze

  # Produces the input fields with a label and <br /> preceding each of them
  INPUT_FIELDS_TO_LABEL.each do |input_field|
    define_method(input_field) do |attribute, options = {}|
      label(attribute) + @template.tag.br + super(attribute, options)
    end
  end
end