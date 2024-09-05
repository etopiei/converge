class Slot < BaseModel

  enum SlotType
    DAY
  end

  table do
    belongs_to event : Event
    column slot_type : Slot::SlotType
    column slot_start : Time
  end
end
