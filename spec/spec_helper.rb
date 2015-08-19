require('rspec')
require('pg')
require('trains')

DB = PG.connect({:dbname => 'train_schedule_test'})



RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM trains *;')
    DB.exec('DELETE FROM cities *;')
  end
end
