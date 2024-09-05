class SaveEvent < Event::SaveOperation
  needs serialized_event : EventCreateSerializer

  before_save do
    name.value = serialized_event.name
    host_name.value = serialized_event.host_name
  end

  after_save do | event |
    # Here create relevant slots
    serialized_event.slots.each do | slot |
      SaveSlot.create!(slot, event_id: event.id)
    end
  end
end
