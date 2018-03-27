class EventSubmitter
  SUBMIT_URL='http://receiver:8080'

  def initialize(events)
    @events = events
  end

  def run
    send_events
  end

  private

  def send_events
    HTTParty.post(
      SUBMIT_URL,
      body: { events: @events }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )
  end
end
