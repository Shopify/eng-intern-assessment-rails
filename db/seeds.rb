# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Article.delete_all
Article.create(title: "Test Title", content: "Test content", author: "test author")
Article.create(title: "Test Title2", content: "Test content", date: DateTime.now)
Article.create(title: "Test Title3", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse ut ullamcorper metus. Aliquam venenatis malesuada felis, non auctor sapien elementum quis. Vestibulum vitae eleifend lacus, sit amet efficitur elit. Ut faucibus fringilla nibh id tincidunt. Quisque commodo rutrum dignissim. Fusce iaculis, arcu eget rutrum fringilla, orci leo dapibus enim, id dignissim neque enim vitae nisi. Aenean id orci posuere augue mattis dignissim. Pellentesque vitae tellus vitae ante finibus rutrum.")
Article.create(title: "Test Title4", content: "Test content", author: "test author", date: DateTime.yesterday)
