require './idea'
require 'yaml'
require 'yaml/store'

class IdeaBoxApp < Sinatra::Base
	# configure development do
	# 	register Sinatra::reloader
	# end
  set :method_override, true

  get '/' do
  	erb :index, locals: {ideas: Idea.all}
  end

  post '/' do
  	idea = Idea.new(params['idea_title'], params['idea_description'])
  	idea.save
  	redirect '/'
	end

  delete '/:index' do |index|
    Idea.delete(index.to_i)
    redirect '/'
  end

  get '/:id/edit' do |id|
    idea = Idea.find(id.to_i)
    erb :edit, locals: {id: id, idea: idea}
  end

  put '/:id' do |id|
    data = {
      :title => params['idea_title'],
      :description => params['idea_description']
    }
    Idea.update(id.to_i, data)
    redirect '/'
  end

  not_found do
    erb :error
  end
end