require 'configured'
require 'redis'

module Natatime
  # Redis connection init.
  db_config_file = File.expand_path('../config/database.yml', __FILE__)
  @@redis = Redis.new(Configured::in_yaml(db_config_file)::for_the :test)
end

require File.expand_path('../../lib/natatime', __FILE__)

