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

end
