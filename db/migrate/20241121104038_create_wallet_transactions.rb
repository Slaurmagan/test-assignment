class CreateWalletTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :wallet_transactions do |t|
      t.integer :wallet_id, null: false
      t.string :transaction_type, null: false
      t.bigint :amount, null: false

      t.timestamps
    end

    add_index :wallet_transactions, :wallet_id
  end
end
