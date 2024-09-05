class Guest < BaseModel
  table do
    belongs_to event : Event
    column name : String
    has_many responses : Response
  end
end
