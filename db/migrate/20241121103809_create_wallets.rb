class CreateWallets < ActiveRecord::Migration[7.1]
  def change
    create_table :wallets do |t|
      t.integer :owner_id, comment: 'Might be empty in case if we want to take commissions'
      t.integer :currency_id, null: false
      t.bigint :available, null: false
      t.bigint :held, default: 0

      t.timestamps
    end

    add_index :wallets, :owner_id
  end
end
