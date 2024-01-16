module ArticlesHelper
    # Helper method to format the date aesthetically
    def format_date(date)
        date.strftime('%B %e, %Y')
    end
end
