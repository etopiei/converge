class Api::Response::CreateResponse < ApiAction
    post "/api/events/:event_uuid/responses" do
        event = EventQuery.new.event_uuid(event_uuid).first
        # TODO: Validate that slot relates to the event in the URL.
        serialized_responses = ResponsesCreateSerializer.from_json(params.body)
        serialized_responses.responses.each do | response |
            SaveResponse.create!(response, guest_id: serialized_responses.guest_id)
        end
        json({ok: true})
    end
end