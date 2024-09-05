class SaveGuest < Guest::SaveOperation
  needs serialized_guest : GuestCreateSerializer

  before_save do
    name.value = serialized_guest.name
  end
end
