module ApplicationHelper

    # Frontend helper for compiling author and/or date values if present
    def format_value(author_value, date_value)
        if !author_value.nil? && !author_value.empty? && !date_value.nil?
            'Written by ' + author_value + ' on ' + date_value.to_s
        elsif !author_value.nil? && !author_value.empty?
            'Written by ' + author_value
        elsif !date_value.nil?
            'Written on ' + date_value.to_s
        else
            ''
        end
    end
end
