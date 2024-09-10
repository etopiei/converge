class Api::Event::Create < ApiAction
  post "/api/events/" do
    serialized_event = EventCreateSerializer.from_json(params.body)
    event = SaveEvent.create!(serialized_event)
    SaveGuestHost.create!(event_id: event.id, name: event.host_name)
    event_with_host = EventQuery.new.preload_guests.event_uuid(event.event_uuid).first
    json EventSerializer.new(event_with_host)
  end
end

class Api::Event::Get < ApiAction
  get "/api/events/:event_uuid" do
    event = EventQuery.new.preload_slots(SlotQuery.new.preload_responses(ResponseQuery.new.preload_guest)).event_uuid(event_uuid).first
    json EventDetailSerializer.new(event)
  end
end
