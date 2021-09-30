class AddConstraint < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :task_name, :string, null: false
    change_column :tasks, :task_details, :text, null: false
    add_index :tasks, :task_name, :unique => true
  end
end
