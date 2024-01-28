# config/initializers/date_patch.rb

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