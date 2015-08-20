class City

  attr_reader :name, :id

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name).capitalize
    @id = attributes.fetch(:id)
  end

  define_method(:save) do
    saved = DB.exec("INSERT INTO cities (name) VALUES ('#{@name}') RETURNING id;")
    @id = saved.first.fetch('id').to_i()
  end

  define_singleton_method(:all) do
    returned_cities = DB.exec("SELECT * FROM cities ORDER BY name ASC;")
    all_cities = []
    returned_cities.each do |city|
      name = city.fetch("name")
      id = city.fetch("id").to_i
      all_cities << City.new({:name => name, :id => id})
    end
    all_cities
  end

  define_method(:==) do |another_city|
    self.name() == another_city.name() && self.id == another_city.id
  end

  define_method(:delete) do
    DB.exec("DELETE FROM cities WHERE id = #{self.id}")
  end

  def self.clear
    DB.exec("DELETE FROM cities *;")
  end

  def update(attributes)
    @name = attributes.fetch(:name)
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{self.id};")
  end

  def self.find(identification)
    found_city = nil
    all_cities = City.all
    all_cities.each do |city|
      found_city = city if city.id == identification
    end
    found_city
  end

  def trains
    returned_trains = DB.exec("SELECT trains.* FROM cities JOIN stops ON (cities.id = stops.city_id) JOIN trains ON (stops.train_id = trains.id) WHERE cities.id = #{self.id} ORDER BY stop_time ASC;")
    all_trains = []
    returned_trains.each do |train|
      id = train.fetch("id").to_i
      line = train.fetch("line")
      all_trains << Train.new({:line => line, :id => id})
    end
    all_trains
  end

  def self.add_major_cities
    listed_cities = ["New York", "Los Angeles", "Chicago", "Houston", "Philadelphia", "Phoenix", "San Antonio", "San Diego", "Dallas", "San Jose", "Austin", "Jacksonville", "San Francisco", "Indianapolis", "Columbus", "Fort Worth", "Charlotte", "Detroit", "El Paso", "Seattle", "Denver", "Washington", "Memphis", "Boston", "Nashville", "Baltimore", "Oklahoma City", "Portland", "Las Vegas", "Louisville", "Milwaukee", "Albuquerque", "Tucson", "Fresno", "Sacramento", "Long Beach", "Kansas City", "Mesa", "Atlanta", "Virginia Beach", "Omaha", "Colorado Springs", "Raleigh", "Miami", "Oakland", "Minneapolis", "Tulsa", "Cleveland", "Wichita", "New Orleans", "Arlington"]
    listed_cities.each do |city|
      city = City.new({:name => city, :id => nil})
      city.save
    end
  end

end
