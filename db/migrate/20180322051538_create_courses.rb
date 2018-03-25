class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :currency_sign
      t.decimal :rate, precision: 5, scale: 3
      t.datetime :uptodate
      t.timestamps
    end
  end
end
