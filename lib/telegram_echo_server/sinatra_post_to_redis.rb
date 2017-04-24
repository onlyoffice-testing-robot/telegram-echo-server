require 'sinatra'
require 'redis-queue'

queue = Redis::Queue.new('payload_queue',
                         'bp_payload_queue',
                         redis: Redis.new)

post '/' do
  return 400 unless params['notification']
  queue.push params['notification']
  'OK'
end
