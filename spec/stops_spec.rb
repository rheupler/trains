require('spec_helper')

describe(Stop) do

  describe('#train_name') do
    it("displays the name of the train with the corresponding train id") do
      new_train = Train.new({:line => "Rick", :id => nil})
      new_train.save
      new_city = City.new({:name => "Portland", :id => nil})
      new_city.save
      new_operator = Operator.new({:id => nil, :name => 'Carl'})
      new_operator.save
      new_stop = Stop.new({:id => nil, :train_id => new_train.id, :city_id => new_city.id, :stop_time => '12:30:00', :operator_id => new_operator.id})
      new_stop.save
      expect(new_stop.train_name).to(eq(new_train.line))
    end
  end

  describe('#city_name') do
    it("displays the name of the city with the corresponding city id") do
      new_train = Train.new({:line => "Rick", :id => nil})
      new_train.save
      new_city = City.new({:name => "Portland", :id => nil})
      new_city.save
      new_operator = Operator.new({:id => nil, :name => 'Carl'})
      new_operator.save
      new_stop = Stop.new({:id => nil, :train_id => new_train.id, :city_id => new_city.id, :stop_time => '12:30:00', :operator_id => new_operator.id})
      new_stop.save
      expect(new_stop.city_name).to(eq(new_city.name))
    end
  end

end
