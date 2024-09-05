class CreateGuests::V20240903003619 < Avram::Migrator::Migration::V1
  def migrate
    # Learn about migrations at: https://luckyframework.org/guides/database/migrations
    create table_for(Guest) do
      primary_key id : Int64
      add_timestamps
    end
  end

  def rollback
    drop table_for(Guest)
  end
end
