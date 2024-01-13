class Article < ApplicationRecord
  # search article by text in title or content
  def self.search(text)
    where("title like ?", "%#{text}%")
      .or(where("content like ?", "%#{text}%"))
  end
end
