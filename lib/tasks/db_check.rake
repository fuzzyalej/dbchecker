namespace :db do
  desc "Checks your database for consistency problems"
  task :check => :environment do
    Dir[File.join(Rails.root,'db/checks/*.rb')].each { |f| load f }
  end
end
