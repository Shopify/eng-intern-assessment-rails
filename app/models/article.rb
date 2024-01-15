class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.search(search)
    search = search.strip
    if search
      result = where("title LIKE ? OR content LIKE ?","%#{search}%",
      "%#{search.strip}%")
    end
    ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    return result
  end
end
