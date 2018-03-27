class ScheduledBatchSender
  include Sidekiq::Worker
  def perform(list_key)
    RedisLocker.with_lock(list_key) do
      if redis.scard(list_key) > 0
        events = redis.smembers(list_key)
        EventSubmitter.new(events).run
        redis.del(list_key)
        redis.set('current_event_queue', "event_queue_#{Time.now.to_i}")
      end
    end
  end

  def redis
    @redis ||= Redis.new(host: "redis", port: 6379)
  end
end
