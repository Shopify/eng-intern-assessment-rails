require 'rails_helper'

RSpec.describe ArticlesHelper, type: :helper do    
  describe '#format_date' do
    it 'formats the date in a user-friendly way' do
      date = Date.new(2022, 1, 15)
      formatted_date = helper.format_date(date)
      expect(formatted_date).to eq('January 15, 2022')
    end
  end
end
