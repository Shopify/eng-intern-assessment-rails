require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'validations' do
    it 'validates presence of title' do
      # This test is to ensure that creating an article without a title is considered invalid
      article = Article.new(content: 'Lorem ipsum')
      expect(article).not_to be_valid
    end

    it 'validates presence of title' do
      # This test is to ensure that creating an article without content is considered invalid
      article = Article.new(title: 'Lorem ipsum')
      expect(article).not_to be_valid
    end
  end
end
