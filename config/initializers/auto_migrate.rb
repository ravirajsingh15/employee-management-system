if Rails.env.production?
  begin
    ActiveRecord::MigrationContext.new(
      ActiveRecord::Migrator.migrations_paths,
      ActiveRecord::SchemaMigration
    ).migrate
  rescue => e
    Rails.logger.error "Auto migration failed: #{e.message}"
  end
end
