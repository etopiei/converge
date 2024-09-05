class CreateEvents::V20240903003557 < Avram::Migrator::Migration::V1
  def migrate
    # Learn about migrations at: https://luckyframework.org/guides/database/migrations
    create table_for(Event) do
      primary_key id : Int64
      add_timestamps
    end
  end

  def rollback
    drop table_for(Event)
  end
end
