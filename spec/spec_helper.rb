ENV["RAILS_ENV"] = "test"

require 'dbchecker'
require 'database_cleaner'

require File.expand_path("../factories.rb",  __FILE__)
require File.expand_path("../dummy/config/environment.rb",  __FILE__)

Rails.backtrace_cleaner.remove_silencers!
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end
  config.before(:each) do
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end
end

class UserSubject < Dbchecker::Checker;model :user;end
class ProfileSubject < Dbchecker::Checker;model :profile;end
class ProviderSubject < Dbchecker::Checker;model :provider;end
