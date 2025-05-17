# config/initializers/date_patch.rb
# patch added because Date.today and Date.yesterday default to a readable format (Sat, 27 Jan 2024 instead of 2024-01-27), due to my computer's localization

class Date
  class << self
    alias_method :original_today, :today

    def today
      original_today.strftime("%Y-%m-%d")
    end

    def yesterday
      original_today.strftime("%Y-%m-%d")
    end
  end
end