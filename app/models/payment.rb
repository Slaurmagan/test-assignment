class Payment < ApplicationRecord
  belongs_to :receiver, class_name: 'User', foreign_key: :receiver_id
  belongs_to :sender, class_name: 'User', foreign_key: :sender_id
  belongs_to :currency

  enum payment_type: { immediate: 'immediate', scheduled: 'scheduled' }
end
