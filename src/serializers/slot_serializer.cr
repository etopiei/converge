class SerializedSlot
    include JSON::Serializable
    property slot_type : Slot::SlotType
    property slot_start : Time
end