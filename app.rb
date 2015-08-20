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

get('/employees/:id/train/new') do
  id = params.fetch("id").to_i
  @operator = Operator.find(id)
  erb(:train)
end

get('/employees/:id/city/new') do
  id = params.fetch("id").to_i
  @operator = Operator.find(id)
  erb(:city)
end

get('/employees/:id/stop/new') do
  id = params.fetch("id").to_i
  @trains = Train.all
  @cities = City.all
  @operator = Operator.find(id)
  erb(:stop)
end

post('/employees/:id/train/new') do
  line = params.fetch("line")
  @train = Train.new({:line => line, :id => nil})
  @train.save
  @trains = Train.all
  id = params.fetch("id").to_i
  @operator = Operator.find(id)
  @stops = Stop.all
  @cities = City.all
  erb(:employee)
end

post('/employees/:id/city/new') do
  name = params.fetch('name')
  @city = City.new({:name => name, :id => nil})
  @city.save
  @cities = City.all
  id = params.fetch('id').to_i
  @operator = Operator.find(id)
  @stops = Stop.all()
  @trains = Train.all()
  erb(:employee)
end

post('/employees/:id/stop/new') do
  city_id = params.fetch('city_id').to_i
  train_id = params.fetch('train_id').to_i
  operator_id = params.fetch('operator_id').to_i
  stop_time = params.fetch('stop_time')
  @stop = Stop.new({:city_id => city_id, :train_id => train_id, :operator_id => operator_id, :stop_time => stop_time, :id => nil})
  @stop.save
  id = params.fetch('id').to_i
  @operator = Operator.find(id)
  @stops = Stop.all()
  @trains = Train.all()
  erb(:employee)
end

delete('/employees/:id/stop/:stop_id') do
  id = params.fetch("id").to_i
  stop_id = params.fetch("stop_id").to_i
  @stop = Stop.find(stop_id)
  @stop.delete
  @operator = Operator.find(id)
  @stops = Stop.all()
  @trains = Train.all
  @cities = City.all
  erb(:employee)
end
