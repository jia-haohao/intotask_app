class ChageTasksPriorityNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tasks, :priority, false, default: 0
  end
end
