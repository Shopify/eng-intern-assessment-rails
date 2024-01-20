require 'rails_helper'

RSpec.describe "articles/new", type: :view do
  before(:each) do
    assign(:article, Article.new())
  end

  it "renders new article form" do
    render

    assert_select "form[action=?][method=?]", articles_path, "post" do
    end
  end
end
