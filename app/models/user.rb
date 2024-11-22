class User < ApplicationRecord
  has_many :wallets, foreign_key: :owner_id

  def wallet_for_currency(currency)
    wallets.where(currency:).take
  end
end
