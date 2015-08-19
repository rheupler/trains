class Operator

  attr_reader :name, :id

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name).capitalize
    @id = attributes.fetch(:id)
  end

  define_method(:save) do
    saved = DB.exec("INSERT INTO operators (name) VALUES ('#{@name}') RETURNING id;")
    @id = saved.first.fetch('id').to_i()
  end

  define_singleton_method(:all) do
    returned_operators = DB.exec("SELECT * FROM operators ORDER BY name ASC;")
    all_operators = []
    returned_operators.each do |operator|
      name = operator.fetch("name")
      id = operator.fetch("id").to_i
      all_operators << Operator.new({:name => name, :id => id})
    end
    all_operators
  end

  define_method(:==) do |another_operator|
    self.name() == another_operator.name() && self.id == another_operator.id
  end

  define_method(:delete) do
    DB.exec("DELETE FROM operators WHERE id = #{self}")
  end

  def update(attributes)
    @name = attributes.fetch(:name)
    DB.exec("UPDATE operators SET name = '#{@name}' WHERE id = #{self.id};")
  end

  def self.find(identification)
    found_operator = nil
    all_operators = Operator.all
    all_operators.each do |operator|
      found_operator = operator if operator.id == identification
    end
    found_operator
  end

end
