require('spec_helper')

describe(Train) do

  describe('#line') do
    it("returns the line of a Train") do
      new_train = Train.new({:line => "Rick", :id => nil})
      expect(new_train.line).to(eq("Rick"))
    end
  end



  describe('#save') do
    it('saves a given instance of the Train class to the database') do
      new_train = Train.new({:line => "Rick", :id => nil})
      new_train.save
      expect(Train.all()).to(eq([new_train]))
    end
  end

  describe('.all') do
    it('returns all saved instances of the Train class, returns none if nothing is there.') do
      new_train = Train.new({:line => "Rick", :id => nil})
      expect(Train.all()).to(eq([]))
    end
  end

  describe('#delete') do
    it('deletes a given instance of the custom class Train') do
      new_train = Train.new({:line => "Rick", :id => nil})
      new_train.save
      new_train.delete()
      expect(Train.all()).to(eq([]))
    end
  end

  describe('#update') do
    it('updates train') do
      new_train = Train.new({:line => "Rick", :id => nil})
      new_train.save
      new_train.update({:line => "Ross"})
      expect(new_train.line()).to(eq("Ross"))
    end
  end

  describe('#find') do
    it("returns train by id") do
      test_train = Train.new({:line => "Rick", :id => nil})
      test_train.save()
      test_train2 = Train.new({:line => "Rock", :id => nil})
      expect(Train.find(test_train.id())).to(eq(test_train))
    end
  end

  describe('#cities') do
    it('returns all cities for a specific train') do
      new_train = Train.new({:line => "Rick", :id => nil})
      new_train.save
      new_city = City.new({:name => "Portland", :id => nil})
      new_city.save
      new_city2 = City.new({:name => "Seattle", :id => nil})
      new_city2.save
      new_operator = Operator.new({:id => nil, :name => 'Carl'})
      new_operator.save
      new_stop = Stop.new({:id => nil, :train_id => new_train.id, :city_id => new_city.id, :stop_time => '12:30:00', :operator_id => new_operator.id})
      new_stop.save
      new_stop2 = Stop.new({:id => nil, :train_id => new_train.id, :city_id => new_city2.id, :stop_time => '06:30:00', :operator_id => new_operator.id})
      new_stop2.save
      expect(new_train.cities()).to(eq([new_city2, new_city]))
    end
  end
end
