class SerializedSlot
  include JSON::Serializable
  property slot_type : Slot::SlotType
  property slot_start : Time
end

class SlotSerializer < BaseSerializer
  def initialize(@slot : Slot)
  end

  def render
    {
      id:        @slot.id,
      type:      @slot.slot_type,
      start:     @slot.slot_start,
      responses: ResponseSerializer.for_collection(@slot.responses),
    }
  end
end
