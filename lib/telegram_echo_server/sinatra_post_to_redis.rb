require 'sinatra'
require 'redis-queue'

module TelegramEchoServer
  # Post stuff to redis db from sinatra request
  class SinatraPostToRedis < Sinatra::Base
    queue = Redis::Queue.new('payload_queue',
                             'bp_payload_queue',
                             redis: Redis.new)

    post '/' do
      return 400 unless params['notification']
      queue.push params['notification']
      'OK'
    end

    run! if app_file == $PROGRAM_NAME
  end
end
