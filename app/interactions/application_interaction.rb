# frozen_string_literal: true

class ApplicationInteraction < ActiveInteraction::Base
  include ActiveInteraction::Extras::All
  set_callback :execute, :around, :catch_errors

  # run callbacks already defined in ActiveInteraction::Extras::RunCallback
  # see https://github.com/antulik/active_interaction-extras/blob/c645764c48e050a78ccf7014b57c197deedc153e/lib/active_interaction/extras/run_callback.rb#L5
  def self.around_run(*args, &block)
    opts = args.extract_options!
    set_callback :run, :around, *args, opts, &block
  end

  def run!
    run

    raise InteractionError, errors unless valid?

    result
  end

  def catch_errors
    yield
  rescue ActiveRecord::RecordInvalid => e
    errors.merge! e.record.errors
  rescue StandardError => e
    errors.add(:base, e.message.presence || 'Undefined Error')
  end


  def has_error_key?(key)
    errors.key?(key)
  end

  class InteractionError < StandardError
    attr_reader :errors, :message

    def initialize(errors)
      super
      @message = errors.full_messages.first
      @errors = errors
    end
  end
end
