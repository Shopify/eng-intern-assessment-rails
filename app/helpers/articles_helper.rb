module ArticlesHelper
  def calculate_read_time(content)
    # Assuming an average reading speed of 150 words per minute
    words_per_minute = 150
    word_count = content.split(/\s+/).length
    read_time = (word_count / words_per_minute).ceil

    [read_time, 1].max
  end
end
