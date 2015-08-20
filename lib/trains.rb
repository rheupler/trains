class Train

  attr_reader :line, :id

  define_method(:initialize) do |attributes|
    @line = attributes.fetch(:line).capitalize
    @id = attributes.fetch(:id)
  end

  define_method(:save) do
    saved = DB.exec("INSERT INTO trains (line) VALUES ('#{@line}') RETURNING id;")
    @id = saved.first.fetch('id').to_i()
  end

  define_singleton_method(:all) do
    returned_trains = DB.exec("SELECT * FROM trains ORDER BY line ASC;")
    all_trains = []
    returned_trains.each do |train|
      line = train.fetch("line")
      id = train.fetch("id").to_i
      all_trains << Train.new({:line => line, :id => id})
    end
    all_trains
  end

  define_method(:==) do |another_train|
        self.line() == another_train.line() && self.id == another_train.id
  end

  define_method(:delete) do
    DB.exec("DELETE FROM trains WHERE id = #{self.id}")
  end

  def self.clear
    DB.exec("DELETE FROM trains *;")
  end

  def update(attributes)
    @line = attributes.fetch(:line)
    DB.exec("UPDATE trains SET line = '#{@line}' WHERE id = #{self.id};")
  end

  def self.find(identification)
    found_train = nil
    all_trains = Train.all
    all_trains.each do |train|
      found_train = train if train.id == identification
    end
    found_train
  end

  def cities
    returned_cities = DB.exec("SELECT cities.* FROM trains JOIN stops ON (trains.id = stops.train_id) JOIN cities ON (stops.city_id = cities.id) WHERE trains.id = #{self.id} ORDER BY stop_time ASC;")
    all_cities = []
    returned_cities.each do |city|
      id = city.fetch("id").to_i
      name = city.fetch("name")
      all_cities << City.new({:name => name, :id => id})
    end
    all_cities
  end

  def self.add_major_trains
    listed_trains = ["Greyhound Bus", "TriMet", "Pain Train", "Haupt-Heupler", "AmTrak", "Gainzzz Trainzzz", "Shame Train", "One-Liner", "Short Bus"]
    listed_trains.each do |train|
      train = Train.new({:line => train, :id => nil})
      train.save
    end
  end

end
