class CreateSlots::V20240903003730 < Avram::Migrator::Migration::V1
  def migrate
    # Learn about migrations at: https://luckyframework.org/guides/database/migrations
    create table_for(Slot) do
      primary_key id : Int64
      add_timestamps
    end
  end

  def rollback
    drop table_for(Slot)
  end
end
