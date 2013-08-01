class CreateSequences < ActiveRecord::Migration
  def change
    create_table :sequences do |t|
      t.text :sequence

      t.timestamps
    end
  end
end
