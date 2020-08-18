class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.references :team, foreign_key: true
      t.references :opponent, foreign_key: true
      t.references :match, foreign_key: true
      t.string :my_kimete
      t.string :aite_kimete
      t.integer :position
      t.timestamps
    end
  end
end
