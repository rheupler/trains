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
end
