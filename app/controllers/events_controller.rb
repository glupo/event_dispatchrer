class EventsController < ApplicationController

  def create
    Event.create(name: create_params)
    render json: {status: 'ok'}, status: 200
  end

  private

  def create_params
    params.require(:event)
  end

end
