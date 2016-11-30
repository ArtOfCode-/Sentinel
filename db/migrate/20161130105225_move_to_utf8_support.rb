class MoveToUtf8Support < ActiveRecord::Migration[5.0]
  def change
    db_config = ActiveRecord::Base.connection_config
    db_name = db_config[:database]

    if db_name.include?('/') || db_name.include?('.')
      name_parts = db_name.split('/')[-1].split('.')
      db_name = name_parts.take(name_parts.size - 1).join('.')
    end

    begin
      execute "ALTER DATABASE #{db_name} CHARACTER SET utf8 COLLATE utf8_general_ci;"

      ActiveRecord::Base.connection.tables.each do |table|
        next if table.match(/\Aschema_migrations\Z/)
        execute "ALTER TABLE #{table} CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci;"
      end
    rescue StandardError => e
      puts "MIGRATION ERROR: Migration to UTF8 errored: possibly unsupported database adapter."
    end
  end
end
