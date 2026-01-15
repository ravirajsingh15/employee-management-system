Rails.application.config.after_initialize do
  next unless Rails.env.production?

  begin
    ActiveRecord::Base.establish_connection

    migration_context =
      if ActiveRecord.version >= Gem::Version.new("6.0")
        ActiveRecord::MigrationContext.new(
          ActiveRecord::Migrator.migrations_paths,
          ActiveRecord::SchemaMigration
        )
      else
        ActiveRecord::Migrator
      end

    migration_context.migrate
    Rails.logger.info "✅ Auto migration completed successfully"
  rescue => e
    Rails.logger.error "❌ Auto migration failed: #{e.class} - #{e.message}"
  end
end
