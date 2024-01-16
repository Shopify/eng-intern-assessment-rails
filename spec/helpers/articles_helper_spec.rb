require 'rails_helper'

RSpec.describe ArticlesHelper, type: :helper do    
  # Describe the helper method 'format_date'
  describe '#format_date' do
    # Specify behavior
    it 'formats the date in a user-friendly way' do

      # Create a specific date for testing
      date = Date.new(2022, 1, 15)

      # Call the helper method
      formatted_date = helper.format_date(date)

      # Check if the formatted date matches the expected result
      expect(formatted_date).to eq('January 15, 2022')
    end
  end
end
