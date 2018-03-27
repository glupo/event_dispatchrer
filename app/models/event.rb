class Event < ApplicationRecord
  BATCH_SIZE = 10
  SEND_INTERVAL = 1.minute

  after_create :push_to_queue

  private

  def push_to_queue
    current_queue = current_event_queue
    RedisLocker.with_lock(current_queue) do
      schedule_queue(current_queue) if redis.scard(current_queue) == 0
      redis.sadd(current_queue, name)
      send_queue(current_queue) if redis.scard(current_queue) >= BATCH_SIZE
    end
  end

  def schedule_queue(queue)
    ScheduledBatchSender.perform_in(SEND_INTERVAL, queue)
  end

  def send_queue(queue)
    ScheduledBatchSender.new.perform(queue)
  end

  def current_event_queue
    redis.get('current_event_queue') || set_new_event_queue
  end

  def set_new_event_queue
    new_queue = "event_queue_#{Time.now.to_i}"
    redis.set('current_event_queue', new_queue) && new_queue
  end

  def redis
    @redis ||= Redis.new(host: "redis", port: 6379)
  end
end
