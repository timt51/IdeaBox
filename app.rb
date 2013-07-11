class IdeaBoxApp < Sinatra::Base
  get '/' do
  	erb :index
  end

  not_found do
    erb :error
  end
end