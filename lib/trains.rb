class Train

  attr_reader :line, :id, :city

  define_method(:initialize) do |attributes|
    @line = attributes.fetch(:line).capitalize
    @city = attributes.fetch(:city).capitalize
    @id = attributes.fetch(:id)
  end

  define_method(:save) do
    saved = DB.exec("INSERT INTO trains (line, city) VALUES ('#{@line}', '#{@city}') RETURNING id;")
    @id = saved.first.fetch('id').to_i()
  end

  define_singleton_method(:all) do
    returned_trains = DB.exec("SELECT * FROM trains ORDER BY city ASC;")
    all_trains = []
    returned_trains.each do |train|
      line = train.fetch("line")
      city = train.fetch("city")
      id = train.fetch("id").to_i
      all_trains << Train.new({:line => line, :city => city, :id => id})
    end
    all_trains
  end

  define_method(:==) do |another_train|
    self.line() == another_train.line() && self.id == another_train.id
  end

  define_method(:delete) do
    DB.exec("DELETE FROM trains WHERE id = #{self.id}")
  end

  def update(attributes)
    @line = attributes.fetch(:line)
    @city = attributes.fetch(:city)
    DB.exec("UPDATE trains SET line = '#{@line}', city = '#{@city}' WHERE id = #{self.id};")
  end

end
