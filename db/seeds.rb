# Clear existing data
Article.delete_all

# Dummy data for anime articles
Article.create!(
  title: 'Studio Ghibli: Masters of Animation',
  content: 'Exploring the enchanting world of Studio Ghibli and the impact of their animated masterpieces.',
  author: 'Miyuki Tanaka',
  date: Date.today
)

Article.create!(
  title: 'Dragon Ball Z: A Legendary Saga',
  content: 'Delving into the epic storyline of Dragon Ball Z and its enduring popularity.',
  author: 'Takeshi Yamamoto',
  date: Date.today - 1.day
)

Article.create!(
  title: 'Manga vs. Anime: The Ongoing Debate',
  content: 'Analyzing the differences and similarities between manga and its animated adaptations.',
  author: 'Aya Nakamura',
  date: Date.today - 2.days
)

Article.create!(
  title: 'Evolution of Anime Genres',
  content: 'How anime genres have evolved over the years and diversified to cater to a global audience.',
  author: 'Hiroshi Suzuki',
  date: Date.today - 3.days
)

Article.create!(
  title: 'The Legacy of Hayao Miyazaki',
  content: 'Reflecting on the profound influence of Hayao Miyazaki on the anime industry and storytelling.',
  author: 'Yukihiro Sato',
  date: Date.today - 4.days
)

Article.create!(
  title: 'Attack on Titan: A Game-Changer in Anime',
  content: 'Examining the impact and success of Attack on Titan as a groundbreaking anime series.',
  author: 'Eriko Tanaka',
  date: Date.today - 5.days
)

Article.create!(
  title: 'The Power of Otaku Culture',
  content: 'Unpacking the global phenomenon of otaku culture and its significance in the anime community.',
  author: 'Kenjiro Yoshida',
  date: Date.today - 6.days
)

Article.create!(
  title: 'My Hero Academia: Rising Stars of Anime',
  content: 'A closer look at the popularity and cultural impact of My Hero Academia in the anime landscape.',
  author: 'Natsumi Honda',
  date: Date.today - 7.days
)

Article.create!(
  title: 'Influence of Japanese Folklore in Anime',
  content: 'Exploring how Japanese folklore and mythology inspire and shape anime narratives.',
  author: 'Masako Nakamura',
  date: Date.today - 8.days
)

Article.create!(
  title: 'Anime and Technology: A Symbiotic Relationship',
  content: 'Investigating how technological advancements have influenced the production and consumption of anime.',
  author: 'Hiroshi Tanaka',
  date: Date.today - 9.days
)
