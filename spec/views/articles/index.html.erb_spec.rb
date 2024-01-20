require 'rails_helper'

RSpec.describe "articles/index", type: :view do
  before(:each) do
    assign(:articles, [
      Article.create!(
        title: "Title",
        content: "Content",
        author: "Author"
      ),
      Article.create!(
        title: "Another Title",
        content: "Content",
        author: "Author"
      )
    ])
  end

  it "renders a list of articles" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 1
    assert_select "tr>td", text: "Another Title".to_s, count: 1
    assert_select "tr>td", text: "Content".to_s, count: 2
    assert_select "tr>td", text: "Author".to_s, count: 2
  end
end
