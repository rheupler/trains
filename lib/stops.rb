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
    returned_stops.each do |train|
      train_id = stop.fetch("train_id").to_i
      operator_id = stop.fetch("operator_id").to_i
      city_id = stop.fetch("city_id").to_i
      stop_time = stop.fetch("stop_time")
      id = train.fetch("id").to_i
      all_stops << Stop.new({:train_id => train_id, :city_id => city_id, :id => id, :operator_id => operator_id, :stop_time => stop_time})
    end
    all_stops
  end

  define_method(:==) do |another_stop|
    self.id() == another_stop.id
  end

  define_method(:delete) do
    DB.exec("DELETE FROM trains WHERE id = #{self.id}")
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

end
