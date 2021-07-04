class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.references :user, foreign_key: true, index: true, null: false
      t.string :status, null: false, default: "backlog"

      t.string :title
      t.text :description

      t.datetime :deadline

      t.timestamps
    end
  end
end
