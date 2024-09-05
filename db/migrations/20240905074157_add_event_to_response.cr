class AddEventToResponse::V20240905074157 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(Response) do
      add_belongs_to event : Event, on_delete: :cascade
    end
  end

  def rollback
    alter table_for(Response) do
      remove :event
    end
  end
end
