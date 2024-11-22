class Wallet < ApplicationRecord
  belongs_to :currency
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  has_many :wallet_transactions

  Error = Class.new(StandardError)
  InsufficientFundsError = Class.new(Error)

  def hold(amount, payment_id)
    with_lock do
      wallet_transactions.create(transaction_type: 'hold', amount:)
    end
  end

  def withdraw(amount, payment_id)
    with_lock do
      check_negative_balance(available, amount)
      wallet_transactions.create(transaction_type: 'withdrawal', amount:)
      decrement!(:available, amount)
    end
  end

  def deposit(amount, payment_id)
    with_lock do
      wallet_transactions.create(transaction_type: 'deposit', amount:)
      increment!(:available, amount)
    end
  end

  def check_negative_balance(current_balance, amount)
    if (current_balance - amount).negative?
      errors.add(:base, :negative_balance)
      raise InsufficientFundsError.new("Negative balance (current_balance: #{current_balance}, amount: #{amount})")
    end
  end
end
