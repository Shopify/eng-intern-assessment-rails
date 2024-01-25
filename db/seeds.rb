# Clear existing data
Article.delete_all

# Dummy data
Article.create!(
  title: 'Michael Jordan: The Greatest of All Time',
  content: 'A look into Michael Jordan\'s legendary career and impact on basketball.',
  author: 'Alex Johnson',
  date: Date.today
)

Article.create!(
  title: 'The 1992 Dream Team: Basketball\'s Best',
  content: 'An overview of the 1992 Olympic Dream Team and their historic run.',
  author: 'Chris Paulson',
  date: Date.today - 1.day
)

Article.create!(
  title: 'LeBron James: A Modern Legend',
  content: 'Exploring the achievements and influence of LeBron James in the NBA.',
  author: 'Diana Roberts',
  date: Date.today - 2.days
)

Article.create!(
  title: 'The Evolution of the Three-Pointer',
  content: 'How the three-pointer has changed the game of basketball over the years.',
  author: 'Emily Clark',
  date: Date.today - 3.days
)

Article.create!(
  title: 'Kobe Bryant\'s Legacy',
  content: 'Remembering Kobe Bryant\'s contributions to basketball and his unique Mamba Mentality.',
  author: 'Frank Timms',
  date: Date.today - 4.days
)

Article.create!(
  title: 'Golden State Warriors: A Dynasty',
  content: 'The rise of the Golden State Warriors and their impact on the NBA.',
  author: 'George Hill',
  date: Date.today - 5.days
)

Article.create!(
  title: 'The Spurs Under Gregg Popovich',
  content: 'Analyzing the San Antonio Spurs\' success under coach Gregg Popovich.',
  author: 'Hannah Lee',
  date: Date.today - 6.days
)

Article.create!(
  title: 'The 2016 NBA Finals: A Historic Comeback',
  content: 'A game-by-game breakdown of the Cleveland Cavaliers\' comeback in the 2016 NBA Finals.',
  author: 'Ian Smith',
  date: Date.today - 7.days
)

Article.create!(
  title: 'Shaquille O\'Neal: The Dominant Force',
  content: 'Reflecting on Shaquille O\'Neal\'s career and his dominance in the paint.',
  author: 'Jenny Gomez',
  date: Date.today - 8.days
)

Article.create!(
  title: 'The Impact of International Players in the NBA',
  content: 'Examining the growing influence of international players in the NBA.',
  author: 'Kevin Lin',
  date: Date.today - 9.days
)
