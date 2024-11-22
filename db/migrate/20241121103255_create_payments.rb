class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false
      t.string :status, null: false
      t.string :payment_type, null: false
      t.integer :amount, null: false
      t.datetime :execute_at
      t.integer :currency_id, null: false

      t.timestamps
    end


    add_index :payments, :execute_at
    add_index :payments, %i[sender_id status payment_type]
    add_index :payments, %i[receiver_id status payment_type]
  end
end
