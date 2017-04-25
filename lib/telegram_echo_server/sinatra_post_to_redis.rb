require 'sinatra'
require 'redis-queue'
require_relative 'sinatra_post_to_redis/sinatra_helper'

include TelegramEchoServer::SinatraHelper

queue = Redis::Queue.new('payload_queue',
                         'bp_payload_queue',
                         redis: Redis.new)

post '/' do
  return 400 unless params['notification']
  queue.push(strong_params(params).to_json)
  'OK'
end
