class Payment::Process < ApplicationInteraction
  object :payment

  delegate :sender, :receiver, :currency, :amount, to: :payment

  def execute
    payment.with_lock do
      sender_wallet.withdraw(amount, payment.id)
      receiver_wallet.deposit(amount, payment.id)
      payment.update(status: 'success')
      payment
    end
  end

  private

  def sender_wallet
    sender.wallet_for_currency(currency)
  end

  def receiver_wallet
    receiver.wallet_for_currency(currency)
  end
end
