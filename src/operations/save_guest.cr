class SaveGuest < Guest::SaveOperation
  needs serialized_guest : GuestCreateSerializer

  before_save do
    validate_required event_id
    name.value = serialized_guest.name
    validate_uniqueness_of name, query: GuestQuery.new.event_id(event_id.value.not_nil!)
  end
end

class SaveGuestHost < Guest::SaveOperation
  permit_columns name, event_id
end
