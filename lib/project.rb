require 'pry'
class Project
  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end
  # overreide the equal operator so that when we compare the 2 objects w the same attributes it is equal
  def ==(other)
    self.class.eql?(other.class) & self.name.eql?(other.name)
  end
  # takes all project names and ids from a database and saves them all in a variable, then pushing it into an array and returning it
  def self.all
    database_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    database_projects.each() do |project|
      name = project.fetch("name")
      id = project.fetch("id").to_i
      projects.push(Project.new({:name => name, :id => id}))
    end
    projects
  end
  # takes a name from a query and inserts it into a projects table, passing in a new id that has been assigned by the database
  def save
    result = DB.exec("INSERT INTO projects (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end
  # clear the result from a database (used for tests)
  def self.clear
    DB.exec("DELETE FROM projects *;")
  end
  # looks for a project by the user inputted ID. Only returns the first resut. Then grabs the name and an id attrb of that result. Then make a new Project obj with those method returns as parameters
  def self.find(id)
    project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
    name = project.fetch("name")
    id = project.fetch("id").to_i
    Project.new({:name => name, :id => id})
  end
  # Match the name in a database to the name in our app
  def update(attributes)
    @name = attributes.fetch :name
    @id = self.id
    DB.exec("UPDATE projects SET name = '#{@name}' WHERE id = #{@id};")
  end
  # Deletes a project from a database by an ID
  def delete
    DB.exec("DELETE FROM projects WHERE id = #{@id};")
    DB.exec("DELETE FROM volunteers WHERE project_id = #{@id};")
  end
  def volunteers
  Volunteer.find_by_project(self.id)
end

end
