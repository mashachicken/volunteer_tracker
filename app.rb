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
get ('/projects/:id/edit') do
  @project = Project.find(params[:id].to_i())
  erb(:edit_project)
end
patch ('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @project.update(params[:name])
  redirect to('/projects')
end
post ('/projects/:id/volunteers') do
  @project = Project.find(params[:id].to_i())
  volunteer = Volunteer.new({:name => params[:volunteer_name], :project_id => @project.id, :id => nil})
  volunteer.save()
  erb(:project)
end
get ('/projects/:id/volunteers/:volunteer_id') do
  @volunteer = Volunteer.find(params[:volunteer_id].to_i())
  erb(:volunteer)
end
patch ('/projects/:id/volunteers/:volunteer_id') do
  @project = Project.find(params[:id].to_i())
  volunteer = Volunteer.find(params[:volunteer_id].to_i())
  volunteer.update(params[:name], @project.id)
  erb(:project)
end
delete ('/projects/:id/volunteers/:volunteer_id') do
  volunteer = Volunteer.find(params[:volunteer_id].to_i())
  volunteer.delete
  @project = Project.find(params[:id].to_i())
  erb(:project)
end
