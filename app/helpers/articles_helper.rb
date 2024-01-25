module ArticlesHelper

  ##Since formating style might change between article and future data types I prefer to tie it to this model
  def published_date(date)
    date.present? ? date.strftime('%A, %b, %d, %Y') : "No publication date"
  end

  ##With nulls allowed for author I think this a reasonable way to handle its display
  def published_author(author)
    author.present? ? author : "Unknown author"
  end
end
