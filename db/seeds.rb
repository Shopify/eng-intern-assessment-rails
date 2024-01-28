# Clearing existing data, and inputting dummy data into the database

# Mock data
Article.create!(
  title: 'Sicilian Defense',
  content: '1. e4 c5',
  author: 'Chess',
  date: Date.today
)

Article.create!(
  title: 'Open Sicilian Defense',
  content: '1.e4 c5 2.Nf3 3.d4 ',
  author: 'Chess',
  date: Date.today
)

Article.create!(
  title: 'Sicilian Najdorf',
  content: '1.e4 c5 2.Nf3 d6 3.d4 cxd4 4.Nxd4 Nf6 5.Nc3 a6',
  author: 'Chess',
  date: Date.today - 2.days
)

Article.create!(
  title: 'Sicilian Scheveningen',
  content: '1.e4 c5 2.Nf3 d6 3.d4 cxd4 4.Nxd4 Nf6 5.Nc3 e6',
  author: 'Chess',
  date: Date.today - 3.days
)

Article.create!(
  title: 'Classical Sicilian Defense',
  content: '1.e4 c5 2.Nf3 d6 3.d4 cxd4 4.Nxd4 Nf6 5.Nc3 Nc6',
  author: 'Chess',
  date: Date.today - 3.days
)

Article.create!(
  title: 'Sicilian Dragon',
  content: '1.e4 c5 2.Nf3 d6 3.d4 cxd4 4.Nxd4 Nf6 5.Nc3 g6',
  author: 'Chess',
  date: Date.today - 5.days
)

Article.create!(
  title: 'Alapin Variation',
  content: '1.e4 c5 2.c3',
  author: 'Checkers',
  date: Date.today - 5.days
)

Article.create!(
  title: 'Chess as a job',
  content: 'I don\'t know man, I\'m a streamer first before a chess player.',
  author: 'Hikaru Nakamura',
  date: Date.today - 5.days
)

Article.create!(
  title: 'Agrees to disagree',
  content: 'Don\t you agree? Yeah, I don\t agree',
  author: 'Magnus Carlsen',
  date: Date.today - 10.days
)
