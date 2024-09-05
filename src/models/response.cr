class Response < BaseModel
  enum ResponseValue
    YES
    NO
    MAYBE
  end

  table do
    belongs_to guest : Guest
    belongs_to slot : Slot
    column response : Response::ResponseValue
  end
end
