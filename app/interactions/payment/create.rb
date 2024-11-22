class Payment::Create < ApplicationInteraction
  integer :sender_id, :receiver_id, :currency_id
  object :sender, class: User, default: -> { User.find(sender_id) }
  object :receiver, class: User, default: -> { User.find(receiver_id) }
  integer :amount
  string :execute_at, default: nil
  string :payment_type

  validate :sender_not_receiver, :negative_amount, :execute_at_validity, :validate_wallets

  def execute
    ActiveRecord::Base.transaction do
      payment = Payment.create(sender:, receiver:, amount:, status: 'created', payment_type:, currency:, execute_at:)

      compose(Payment::Process, { payment: }) if payment.immediate?
      payment
    end
  end

  private

  def currency
    Currency.find(currency_id)
  end

  def sender_not_receiver
    errors.add(:base, 'sender cant be receiver') if sender == receiver
  end

  def negative_amount
    errors.add(:amount, 'cant be negative') if amount.negative?
  end

  def execute_at_validity
    return errors.add(:execute_at, 'cant be set for immediate payment') if payment_type == Payment.payment_types[:immediate] && execute_at.present?
    return errors.add(:execute_at, 'cant be empty') if payment_type == Payment.payment_types[:scheduled] && execute_at.blank?

    binding.pry
    errors.add(:execute_at, 'cant be in past') if payment_type == Payment.payment_types[:scheduled] && execute_at < Time.current
  end

  def validate_wallets
    errors.add(:base, 'wallets should exists') unless sender_wallet && receiver_wallet
  end

  def sender_wallet
    sender.wallet_for_currency(currency)
  end

  def execute_at
    DateTime.parse(inputs[:execute_at])
  end

  def receiver_wallet
    receiver.wallet_for_currency(currency)
  end
end
