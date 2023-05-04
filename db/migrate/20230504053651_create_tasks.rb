class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :content
      t.integer :priority
      t.integer :status
      t.date :deadline

      t.timestamps
    end
  end
end
