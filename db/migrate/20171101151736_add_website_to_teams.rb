class AddWebsiteToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :website, :string
  end
end
