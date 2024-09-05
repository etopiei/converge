class GuestSerializer < BaseSerializer
  def initialize(@guest : Guest)
  end

  def render
    {
      name: @guest.name,
    }
  end
end

class GuestCreateSerializer
  include JSON::Serializable
  property name : String
end
