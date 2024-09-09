class Api::Response::CreateResponse < ApiAction
  post "/api/events/:event_uuid/responses" do
    event = EventQuery.new.event_uuid(event_uuid).preload_slots.first
    serialized_responses = ResponsesCreateSerializer.from_json(params.body)

    slot_ids = event.slots.map do |slot|
      slot.id
    end
    ok_slots = true
    serialized_responses.responses.each do |response|
      if !slot_ids.includes?(response.slot_id)
        ok_slots = false
      end
    end

    if !ok_slots
      json({error: "Slot doesn't belong to event"}, HTTP::Status::UNAUTHORIZED)
    else
      current_responses = ResponseQuery.new.guest_id(serialized_responses.guest_id)
      current_responses.each do |response|
        DeleteResponse.delete!(response)
      end

      serialized_responses.responses.each do |response|
        SaveResponse.create!(response, guest_id: serialized_responses.guest_id)
      end
      json({ok: true})
    end
  end
end
