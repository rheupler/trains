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

end
