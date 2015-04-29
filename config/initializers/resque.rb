Resque.redis = $redis
# Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }

# Open the new separate log file
logfile_path = ENV['RESQUE_LOG_PATH'] || File.join(Rails.root, 'log', 'resque.log')

logfile = File.open(logfile_path, 'a')

# Activate file synchronization
logfile.sync = true

# Create a new buffered logger
Resque.logger = ActiveSupport::Logger.new(logfile)
Resque.logger.level = Logger::INFO
Resque.logger.info "Resque Logger Initialized!"
