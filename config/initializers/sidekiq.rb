# frozen_string_literal: true

Sidekiq.strict_args!(false)

redis =
  if Rails.env.development? || Rails.env.test?
    {
      url: ENV.fetch('REDIS_URL', 'redis://redis:6379/0')
    }
  else
    {
      url: ENV.fetch('REDIS_URL', 'redis://redis:6379/0'),
      password: ENV.fetch('REDIS_PASS', 'redis-pass')
    }
  end

Sidekiq.configure_client do |config|
  config.redis = redis
end

Sidekiq.configure_server do |config|
  config.redis = redis
end
