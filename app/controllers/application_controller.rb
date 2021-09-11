require './config/environment'

class ApplicationController < Sinatra::Base
  # register Sinatra::ActiveRecordExtension
  #set :views, Proc.new { File.join(root, "../views/") }

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # 3) set up a controller action that will render a form to create a new recipe. 
  # This controller action should create and save this new recipe to the database

  get '/recipes/new' do #load the form to create a new recipe (New Action)
    erb :new
  end

  post '/recipes' do  #creates a recipe and saves to database (New Action)
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do  #4) Restful route for a Show Action; loads show page and displays a single recipe
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do #5) Restful route; loads edit form
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do  # Restful route; updates a recipe
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  get '/recipes' do #loads index page; 6) create index action
    # allows the view to display all the articles in the database using the instance variable @recipes
    @recipes = Recipe.all
    erb :index
  end

  delete '/recipes/:id' do # 7) deletes a recipe
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect to '/recipes'
  end

end