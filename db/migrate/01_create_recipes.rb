class CreateRecipes < ActiveRecord::Migration[5.1] # 1) Create a table to store recipes
    def change
      create_table :recipes do |t|
        t.string :name
        t.string :ingredients
        t.string :cook_time
      end
    end
end