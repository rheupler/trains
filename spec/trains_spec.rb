require('spec_helper')

describe(Train) do

  describe('#line') do
    it("returns the line of a Train") do
      new_train = Train.new({:line => "Rick", :city => "Portland", :id => nil})
      expect(new_train.line).to(eq("Rick"))
    end
  end

  describe('#city') do
    it("returns the city name of a Train") do
      new_train = Train.new({:line => "Rick", :city => "portland", :id => nil})
      expect(new_train.city).to(eq("Portland"))
    end
  end


  describe('#save') do
    it('saves a given instance of the Train class to the database') do
      new_train = Train.new({:line => "Rick", :city => "Portland", :id => nil})
      new_train.save
      expect(Train.all()).to(eq([new_train]))
    end
  end

  describe('.all') do
    it('returns all saved instances of the Train class, returns none if nothing is there.') do
      new_train = Train.new({:line => "Rick", :city => "Portland", :id => nil})
      expect(Train.all()).to(eq([]))
    end
  end

  describe('#delete') do
    it('deletes a given instance of the custom class Train') do
      new_train = Train.new({:line => "Rick", :city => "Portland", :id => nil})
      new_train.save
      new_train.delete()
      expect(Train.all()).to(eq([]))
    end
  end

end
