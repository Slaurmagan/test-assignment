class PaymentsController < ApplicationController

  def index
    @payment = Payment.new
    @payments = Payment.all.order(created_at: :desc)
  end

  def create
    command = Payment::Create.run(payment_params)

    if command.valid?
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: [
            turbo_stream.replace("payment_form", partial: "payments/form", locals: { payment: Payment.new }),
            turbo_stream.prepend('payments', partial: 'payments/payment', locals: { payment: command.result }),
            turbo_stream.replace("errors", partial: "payments/errors", locals: { errors: [] })
          ]
        }
      end
    else
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: [
            turbo_stream.replace("errors", partial: "payments/errors", locals: { errors: command.errors })
          ]
        }
      end
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:sender_id, :receiver_id, :execute_at, :payment_type, :amount, :currency_id)
  end
end
