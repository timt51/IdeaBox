class Idea
	attr_reader :title, :description

	def initialize(title, description)
		@title = title
		@description = description
	end

	def save
		database.transaction do |db|
    	db['ideas'] ||= []
    	db['ideas'] << {title: title, description: description}
  	end
	end

  def database
    Idea.database
  end

	def self.all
	  raw_ideas.map do |data|
	    Idea.new(data[:title], data[:description])
	  end
	end

	def self.raw_ideas
	  database.transaction do
	    database['ideas']
	  end
	end

  def self.database
    @database ||= YAML::Store.new('ideabox')
  end
end