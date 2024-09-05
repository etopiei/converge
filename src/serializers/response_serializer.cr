class ResponseSerializer < BaseSerializer
  def initialize(@response : Response)
  end

  def render
    {
      response: @response.response,
      guest:    GuestSerializer.new(@response.guest),
    }
  end
end

class ResponsesCreateSerializer
  include JSON::Serializable
  property guest_id : Int64
  property responses : Array(ResponseCreateSerializer)
end

class ResponseCreateSerializer
    include JSON::Serializable
    property response : Response::ResponseValue
    property slot_id : Int64
end