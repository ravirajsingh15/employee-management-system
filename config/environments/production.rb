require "active_support/core_ext/integer/time"

Rails.application.configure do
  # ===============================
  # BASIC SETTINGS
  # ===============================
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # ===============================
  # MASTER KEY
  # ===============================
  config.require_master_key = true

  # ===============================
  # STATIC FILES / ASSETS
  # ===============================
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?
  config.assets.compile = false

  # ===============================
  # ACTIVE STORAGE
  # ===============================
  config.active_storage.service = :local

  # ===============================
  # SSL
  # ===============================
  config.force_ssl = true

  # ===============================
  # LOGGING
  # ===============================
  config.log_level = :info
  config.log_tags = [:request_id]
  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  # ===============================
  # I18N
  # ===============================
  config.i18n.fallbacks = true

  # ===============================
  # ACTIVE RECORD
  # ===============================
  config.active_record.dump_schema_after_migration = false
  config.action_controller.forgery_protection_origin_check = true

  # ===============================
  # HOST AUTHORIZATION
  # ===============================
  config.hosts << ".onrender.com"

  config.action_mailer.default_url_options = {
    host: "employee-management-system.onrender.com",
    protocol: "https"
  }

  Rails.application.routes.default_url_options[:host] = "employee-management-system.onrender.com"
  Rails.application.routes.default_url_options[:protocol] = "https"

  # ===============================
  # SESSION / CSRF
  # ===============================
  config.session_store :cookie_store,
    key: "_employee_management_session",
    secure: true,
    same_site: :lax

  # ===============================
  # MAILER – TEMPORARILY DISABLED ✅
  # ===============================
  config.action_mailer.perform_deliveries = false
  config.action_mailer.raise_delivery_errors = false
end
