require('spec_helper')

describe(City) do

  describe('#name') do
    it("returns the name of a City") do
      new_city = City.new({:name => "portland", :id => nil})
      expect(new_city.name).to(eq("Portland"))
    end
  end

  describe('#save') do
    it('saves a given instance of the City class to the database') do
      new_city = City.new({:name => "Portland", :id => nil})
      new_city.save
      expect(City.all()).to(eq([new_city]))
    end
  end

  describe('.all') do
    it('returns all saved instances of the City class, returns none if nothing is there.') do
      new_city = City.new({:name => "Portland", :id => nil})
      expect(City.all()).to(eq([]))
    end
  end

  describe('#delete') do
    it('deletes a given instance of the custom class City') do
      new_city = City.new({:name => "Portland", :id => nil})
      new_city.save
      new_city_2 = City.new({:name => "Philly", :id => nil})
      new_city_2.save
      new_city.delete()
      expect(City.all()).to(eq([new_city_2]))
    end
  end

  describe('#update') do
    it('updates city') do
      new_city = City.new({:name => "Portland", :id => nil})
      new_city.save
      new_city.update({:name => "Philly"})
      expect(new_city.name()).to(eq("Philly"))
    end
  end

  describe('#find') do
    it("returns city by id") do
      test_city = City.new({:name => "Portland", :id => nil})
      test_city.save()
      test_city2 = City.new({:name => "Philly", :id => nil})
      test_city2.save
      expect(City.find(test_city.id())).to(eq(test_city))
    end
  end


end
