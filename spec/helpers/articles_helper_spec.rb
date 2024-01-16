require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ArticlesHelper. For example:
#
# describe ArticlesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ArticlesHelper, type: :helper do    
  describe '#format_date' do
    it 'formats the date in a user-friendly way' do
      date = Date.new(2022, 1, 15)
      formatted_date = helper.format_date(date)
      expect(formatted_date).to eq('January 15, 2022')
    end
  end
end
