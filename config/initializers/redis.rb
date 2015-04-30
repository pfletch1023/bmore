# Use RedisToGo or localhost
redis_uri = URI.parse(ENV['REDISCLOUD_URL'] || 'redis://127.0.0.1')
$redis = Redis.new(host: redis_uri.host, port: redis_uri.port, password: redis_uri.password)
