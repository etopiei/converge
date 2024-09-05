class AddDataToEvent::V20240905011612 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(Slot) do
      add_belongs_to event : Event, on_delete: :cascade
      add slot_type : Int32, fill_existing_with: 0
      add slot_start : Time, fill_existing_with: :nothing
    end

    alter table_for(Event) do
      add event_uuid : String, default: UUID.v7.to_s
      add name : String, fill_existing_with: :nothing
      add host_name : String, fill_existing_with: :nothing
    end

    alter table_for(Guest) do
      add_belongs_to event : Event, on_delete: :cascade
      add name : String, fill_existing_with: :nothing
    end

    alter table_for(Response) do
      add_belongs_to guest : Guest, on_delete: :cascade
      add_belongs_to slot : Slot, on_delete: :cascade
      add response : Int32, fill_existing_with: :nothing
    end
  end

  def rollback
    alter table_for(Slot) do
      remove :event_id
      remove :slot_type
      remove :slot_start
    end
    alter table_for(Event) do
      remove :name
      remove :host_name
      remove :event_uuid
    end
    alter table_for(Guest) do
      remove :event_id
      remove :name
    end

    alter table_for(Response) do
      remove :guest_id
      remove :slot_id
      remove :response
    end
  end
end
