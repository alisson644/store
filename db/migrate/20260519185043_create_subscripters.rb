class CreateSubscripters < ActiveRecord::Migration[8.1]
  def change
    create_table :subscripters do |t|
      t.belongs_to :product, null: false, foreign_key: true
      t.string :email

      t.timestamps
    end
  end
end
