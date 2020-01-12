require 'sinatra'
require 'sinatra/reloader'
require './lib/project.rb'
require './lib/volunteer.rb'
require 'pg'
require 'pry'
DB = PG.connect({:dbname => "volunteer_tracker"})
get('/') do
  redirect to('/projects')
end
get('/projects') do
  @projects = Project.all
  # @projects_sold = Project].all_sold
  erb(:projects)
end
get ('/projects/new') do
  erb(:new_project)
end
post ('/projects') do
  name = params[:project_name]
  project = Project.new({:name => name, :id => nil})
  project.save()
  redirect to('/projects')
end
get ('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  erb(:project)
end
post ('/new_volunteer') do
  name = params.fetch("name")
  project_id = params.fetch("project_id")
  volunteer = Volunteer.new({:name => name, :project_id => project_id, :id => nil})
  volunteer.save
  @projects = Project.all
  @volunteers = Volunteer.all
  erb(:projects)
end
# get ('/projects/:id') do
#   @project = Project].find(params[:id].to_i())
#   erb(:project)
# end
