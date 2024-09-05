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
      slot_type:  @slot.slot_type,
      slot_start: @slot.slot_start,
    }
  end
end
