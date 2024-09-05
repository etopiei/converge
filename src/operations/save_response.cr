class SaveResponse < Response::SaveOperation
  needs serialized_response : ResponseCreateSerializer

  before_save do
    slot_id.value = serialized_response.slot_id
    response.value = serialized_response.response
  end
end
