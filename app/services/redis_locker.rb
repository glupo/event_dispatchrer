class RedisLocker
  LOCK_DURATION = 1000
  class << self

    def with_lock(key, &block)
      begin
        lock = locker.lock(mutex_for(key), LOCK_DURATION)
        yield
      ensure
        locker.unlock(lock) if lock
      end
    end

    def locker
      @locker ||= Redlock::Client.new(['redis://redis:6379'])
    end

    def mutex_for(key)
      "#{key.to_s}_mutex"
    end
  end

end
