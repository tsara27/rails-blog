class AddAnonToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :anon, :boolean
  end
end
