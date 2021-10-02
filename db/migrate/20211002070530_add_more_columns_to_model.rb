class AddMoreColumnsToModel < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :priority, :integer, default: 1
    add_column :tasks, :status, :string, default:"Unstarted"
    add_column :tasks, :deadline, :datetime, default: "31/09/2021 00:00"
  end
end
