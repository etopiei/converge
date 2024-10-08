class EventSerializer < BaseSerializer
  def initialize(@event : Event)
  end

  def render
    {
      event_uuid: @event.event_uuid,
      name:       @event.name,
      host_name:  @event.host_name,
      host_id:    @event.guests.first.id,
    }
  end
end

class EventCreateSerializer
  include JSON::Serializable
  property name : String
  property host_name : String
  property slots : Array(SerializedSlot)
end

class EventDetailSerializer < BaseSerializer
  def initialize(@event : Event)
  end

  def render
    {
      name:      @event.name,
      host_name: @event.host_name,
      slots:     SlotSerializer.for_collection(@event.slots),
    }
  end
end
