class Volunteer
  attr_accessor :name

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end
  def self.all
    returned_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    returned_volunteers.each() do |volunteer|
      name = volunteer.fetch("name")
      id = volunteer.fetch("id").to_i
      volunteers.push(Volunteer.new({:name => name, :id => id}))
    end
    volunteers
  end
  def ==(other)
    self.class.eql?(other.class) & self.name.eql?(other.name)
  end
  def save
    result = DB.exec("INSERT INTO volunteers (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end
  def self.clear
  DB.exec("DELETE FROM volunteers *;")
end
def self.find(id)
   volunteer= DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
   name = volunteer.fetch("name")
   id = volunteer.fetch("id").to_i
   Volunteer.new({:name => name, :id => id})
 end
end
