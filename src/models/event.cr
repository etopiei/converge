class Event < BaseModel
  table do
    column name : String
    column host_name : String
    column event_uuid : String = UUID.v7.to_s
    has_many slots : Slot
    has_many responses : Response
  end
end
