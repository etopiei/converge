class Api::Event::Create < ApiAction
    post "/api/events" do
        serialized_event = EventCreateSerializer.from_json(params.body)
        event = SaveEvent.create!(serialized_event)
        json EventSerializer.new(event)
    end
end