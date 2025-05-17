

namespace :db do
    desc 'Clear all seeded data'
    task clear_seeds: :environment do
      Article.delete_all
     
    end
  end
  