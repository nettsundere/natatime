require 'configured'
require 'redis'

module Spec
  # Redis configuration file.
  @@db_config_file = File.expand_path('../config/database.yml', __FILE__)
  
  class << self
    # Connect to the redis db.
    def redis_connect
      Redis.new(Configured.in_yaml(@@db_config_file).for_the :test)
    end
    
    # Disconnect redis db.
    def redis_disconnect(instance)
      instance.quit
    end
  end
end

require File.expand_path('../../lib/natatime', __FILE__)

