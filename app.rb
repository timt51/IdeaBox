require './idea'
require 'yaml'
require 'yaml/store'

class IdeaBoxApp < Sinatra::Base
	# configure development do
	# 	register Sinatra::reloader
	# end

  get '/' do
  	erb :index, locals: {ideas: Idea.all}
  end

  post '/' do
  	idea = Idea.new(params['idea_title'], params['idea_description'])
  	idea.save
  	redirect '/'
	end

  not_found do
    erb :error
  end
end