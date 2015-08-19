require('sinatra')
require('sinatra/reloader')
require('./lib/trains')
require('./lib/cities')
also_reload('lib/**/*.rb')

get('/') do
  erb(:index)
end

get('/employees') do
  @operators = Operator.all
  erb(:employees)
end

get('/employees/:id/delete/') do
  id = params.fetch("id")
  

get('/employees') do
  erb(:employee_form)
