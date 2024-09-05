class Api::Guest::Create < ApiAction
    post "/api/events/:event_uuid/guest" do
        event = EventQuery.new.event_uuid(event_uuid).first
        guest_data = GuestCreateSerializer.from_json(params.body)
        guest = SaveGuest.create!(guest_data, event_id: event.id)
        json({guest_id: guest.id})
    end
end