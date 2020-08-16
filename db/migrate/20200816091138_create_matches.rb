class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.references :school, foreign_key: true
      t.references :place, foreign_key: true
      t.timestamps
    end
  end
end
