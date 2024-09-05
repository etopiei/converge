class SaveSlot < Slot::SaveOperation
  needs serialized_slot : SerializedSlot

  before_save do
    slot_type.value = serialized_slot.slot_type
    slot_start.value = serialized_slot.slot_start
  end
end
