require 'byebug'
require 'json'


class Receiver
  class << self
    def call(env)
      req = Rack::Request.new(env)
      events = JSON.parse(req.body.read)["events"]
      events.nil? ? failure : success(events)
    end

    def success(events)
      $stdout << log_string(events)
      [
        200,
        {"Content-Type" => "text/html"},
        ["All good dude, events #{events.join(', ')} submitted!"]
      ]
    end

    def failure
      [
        400,
        {"Content-Type" => "text/html"},
        ["Gimme some events pls."]
      ]
    end

    def log_string(events)
      "\nEvents (#{events.join(', ')}) were submitted! \n"
    end
  end
end
