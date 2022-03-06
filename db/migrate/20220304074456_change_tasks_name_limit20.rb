class ChangeTasksNameLimit20 < ActiveRecord::Migration[6.1]
  def up
    change_column :tasks, :name, :string, null: false, limit: 20
  end
  def down
    change_column :tasks, :name, :string, null: false
  end
end
