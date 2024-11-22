class ScheduledPaymentsWorker < ApplicationWorker
  def perform
    Payment.where(execute_at: ..Time.current, status: 'created').each do
      Payment::Process.run(payment: _1)
    end
  end
end
