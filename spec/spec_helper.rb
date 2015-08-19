require('rspec')
require('pg')
require('trains')
require('cities')
require('operators')
require('stops')

DB = PG.connect({:dbname => 'train_schedule_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM trains *;')
    DB.exec('DELETE FROM cities *;')
    DB.exec('DELETE FROM operators *;')
    DB.exec('DELETE FROM stops *;')
  end
end
