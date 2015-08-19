require('sinatra')
require('sinatra/reloader')
require('./lib/trains')
require('./lib/cities')
require('./lib/stops')
require('./lib/operators')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => 'train_schedule'})

get('/') do
  erb(:index)
end

get('/employees') do
  @operators = Operator.all()
  erb(:employees)
end

delete('/employees/:id') do
  id = params.fetch("id").to_i
  @operator = Operator.find(id)
  @operator.delete
  @operators = Operator.all()
  erb(:employees)
end

get('/employees/new') do
  erb(:employees_form)
end

post('/employees') do
  name = params.fetch("name")
  @operator = Operator.new({:name => name, :id => nil})
  @operator.save
  @operators = Operator.all
  erb(:employees)
end

get('/employees/:id') do
  id = params.fetch("id").to_i
  @operator = Operator.find(id)
  @trains = Train.all()
  @stops = Stop.all
  @cities = City.all
  erb(:employee)
end

post('/employees') do
  name = params.fetch("name")
  @train = Train.new({:name => name, :id => nil})
  @train.save
  @trains = Train.all
  erb(:employee)
end
