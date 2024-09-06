class GuestSerializer < BaseSerializer
  def initialize(@guest : Guest)
  end

  def render
    {
      name: @guest.name,
      id:   @guest.id,
    }
  end
end

class GuestCreateSerializer
  include JSON::Serializable
  property name : String
end
