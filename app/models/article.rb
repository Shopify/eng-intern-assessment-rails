class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.search(query)
    where("title like :q OR content like :q OR author like :q", q: "%#{sanitize_sql_like(query)}%")
  end
end
