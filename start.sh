service redis-server start
rake telegram_monitor &
ruby lib/telegram_echo_server/sinatra_post_to_redis.rb -p 80 -o 0.0.0.0
