class Stop

  attr_reader :train_id, :city_id, :operator_id, :stop_time, :id

  define_method(:initialize) do |attributes|
    @train_id = attributes.fetch(:train_id)
    @city_id = attributes.fetch(:city_id)
    @operator_id = attributes.fetch(:operator_id)
    @stop_time = attributes.fetch(:stop_time)
    @id = attributes.fetch(:id)
  end


  define_method(:save) do
    saved = DB.exec("INSERT INTO stops (train_id, city_id, operator_id, stop_time) VALUES ('#{@train_id}', '#{@city_id}', '#{@operator_id}', '#{@stop_time}') RETURNING id;")
    @id = saved.first.fetch('id').to_i()
  end

  define_singleton_method(:all) do
    returned_stops = DB.exec("SELECT * FROM stops ORDER BY stop_time ASC;")
    all_stops = []
    returned_stops.each do |stop|
      train_id = stop.fetch("train_id").to_i
      operator_id = stop.fetch("operator_id").to_i
      city_id = stop.fetch("city_id").to_i
      stop_time = stop.fetch("stop_time")
      id = stop.fetch("id").to_i
      all_stops << Stop.new({:train_id => train_id, :city_id => city_id, :id => id, :operator_id => operator_id, :stop_time => stop_time})
    end
    all_stops
  end

  define_method(:==) do |another_stop|
    self.id() == another_stop.id
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stops WHERE id = #{self.id}")
  end

  def update(attributes)
    @train_id = attributes.fetch(:train_id)
    @city_id = attributes.fetch(:city_id)
    @operator_id = attributes.fetch(:operator_id)
    @stop_time = attributes.fetch(:stop_time)
    @id = attributes.fetch(:id)
    DB.exec("UPDATE stops SET train_id = '#{@train_id}', city_id = '#{@city_id}', operator_id = '#{@operator_id}', stop_time = '#{@stop_time}' WHERE id = #{self.id};")
  end

  def self.find(identification)
    found_stop = nil
    all_stops = Stop.all
    all_stops.each do |stop|
      found_stop = stop if stop.id == identification
    end
    found_stop
  end

  def self.operator_stops(operator)
    returned_stops = DB.exec("SELECT * FROM stops WHERE operator_id = #{operator.id};")
    all_stops = []
    returned_stops.each do |stop|
      train_id = stop.fetch("train_id").to_i
      operator_id = stop.fetch("operator_id").to_i
      city_id = stop.fetch("city_id").to_i
      stop_time = stop.fetch("stop_time")
      id = stop.fetch("id").to_i
      all_stops << Stop.new({:train_id => train_id, :city_id => city_id, :id => id, :operator_id => operator_id, :stop_time => stop_time})
    end
    all_stops
  end

  def train_name
    train_id = self.train_id
    train = Train.find(train_id)
    train.line
  end

  def city_name
    city_id = self.city_id
    city = City.find(city_id)
    city.name
  end

  def random_time
    hours = rand(23)
    minutes_array = [15, 30, 45, 0]
    minutes = minutes_array[rand(3)]
    afternoon_array = ["AM", "PM"]
    afternoon = afternoon_array[rand(1)]
    if hours > 12
      hours = hours - 12
    end
    if hours < 10
      hours = "0#{hours}"
    else
      hours = "#{hours}"
    end
    if minutes == 0
      minutes = "00"
    else
      minutes = "#{minutes}"
    end
    random_time = "#{hours}:#{minutes} #{afternoon}"
  end

end
