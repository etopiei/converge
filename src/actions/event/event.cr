class Api::Event::Create < ApiAction
  post "/api/events/" do
    serialized_event = EventCreateSerializer.from_json(params.body)
    event = SaveEvent.create!(serialized_event)
    json EventSerializer.new(event)
  end
end

class Api::Event::Get < ApiAction
  get "/api/events/:event_uuid" do
    event = EventQuery.new.preload_slots(SlotQuery.new.preload_responses).event_uuid(event_uuid).first
    json EventDetailSerializer.new(event)
  end
end
