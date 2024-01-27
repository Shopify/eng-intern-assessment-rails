class Article < ApplicationRecord
   def self.search(query)
      where("title LIKE ? OR content LIKE ? OR author LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
   end

   # Title and content are mandatory, other fields are optional
   validates :title, :content, presence: true, if: :should_validate?
   
   private
   # We should validate records when creating or editing, but allow deletion to bypass validation so we can delete articles in a bad state
      def should_validate?
         new_record? || changed?
      end
end