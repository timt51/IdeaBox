require 'idea_box'
require 'yaml'
require 'yaml/store'

class IdeaBoxApp < Sinatra::Base
  set :method_override, true
  set :root, 'lib/app'

  get '/' do
    erb :index, locals: {ideas: IdeaStore.all, idea: Idea.new}
  end

  post '/' do
    idea = IdeaStore.create(params[:idea])
    idea.save
    redirect '/'
  end

  delete '/:index' do |index|
    IdeaStore.delete(index.to_i)
    redirect '/'
  end

  get '/:id/edit' do |id|
    idea = IdeaStore.find(id.to_i)
    erb :edit, locals: {idea: idea}
  end

  put '/:id' do |id|
    IdeaStore.update(id.to_i, params[:idea])
    redirect '/'
  end

  post '/:id/like' do |id|
    idea = IdeaStore.find(id.to_i)
    idea.like!
    IdeaStore.update(id.to_i, idea.to_h)
    "I like this idea!"
    redirect '/'
  end

  get '/' do
    erb :index, locals: {ideas: IdeaStore.all.sort, idea: Idea.new}
  end

  not_found do
    erb :error
  end
end