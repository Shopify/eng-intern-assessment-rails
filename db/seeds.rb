# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create sample articles using GraphQL mutations
articles_data = [
  {
    title: "The Future of Artificial Intelligence in Healthcare",
    content: "Recent developments in AI have shown promising results in medical diagnosis and treatment planning. Machine learning algorithms are now being used to analyze medical images with remarkable accuracy, potentially reducing human error in diagnosis.",
    author: "Dr. Sarah Chen",
    date: Date.current - 2.days,
    categories: ["Technology", "Healthcare", "AI"]
  },
  {
    title: "Sustainable Living: A Beginner's Guide",
    content: "Making small changes in your daily life can have a big impact on the environment. From reducing plastic waste to conserving energy, there are many ways to live more sustainably. This guide will walk you through the basics of eco-friendly living.",
    author: "Emma Thompson",
    date: Date.current - 5.days,
    categories: ["Environment", "Lifestyle", "Sustainability"]
  },
  {
    title: "The Art of Mindful Cooking",
    content: "Cooking isn't just about preparing food; it's an opportunity to practice mindfulness. By focusing on the present moment and engaging all your senses, you can transform your cooking experience into a meditative practice.",
    author: "Chef Michael Chang",
    date: Date.current - 1.week,
    categories: ["Food", "Wellness", "Mindfulness"]
  },
  {
    title: "Digital Privacy in the Modern Age",
    content: "With the increasing amount of personal data being collected online, understanding digital privacy has never been more important. Learn about the best practices for protecting your personal information and maintaining your online privacy.",
    author: "Alex Rivera",
    date: Date.current - 3.days,
    categories: ["Technology", "Privacy", "Security"]
  },
  {
    title: "The Benefits of Regular Exercise",
    content: "Regular physical activity is essential for maintaining good health. Studies show that even moderate exercise can improve cardiovascular health, boost mental well-being, and increase overall longevity. Here's what you need to know about starting and maintaining an exercise routine.",
    author: "Dr. James Wilson",
    date: Date.current - 1.day,
    categories: ["Health", "Fitness", "Wellness"]
  }
]

# Create a GraphQL context
context = {
  current_user: nil,
  schema: Schema
}

articles_data.each do |article_data|
  mutation = <<~GQL
    mutation CreateArticle($input: CreateArticleInput!) {
      createArticle(input: $input) {
        article {
          id
          title
          content
          author
          date
          categories
        }
        errors
      }
    }
  GQL

  variables = {
    input: article_data
  }

  result = Schema.execute(
    mutation,
    variables: variables,
    context: context
  )

  if result["errors"]
    puts "Error creating article: #{result['errors']}"
  else
    puts "Created article: #{article_data[:title]}"
  end
end
