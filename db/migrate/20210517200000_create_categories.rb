class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name
    end

    # Creating categories
    Category.create(:name => "Art")
    Category.create(:name => "Event")
    Category.create(:name => "Furry science")
    Category.create(:name => "Game")
    Category.create(:name => "Pokemons")
    Category.create(:name => "Other")
  end
end
