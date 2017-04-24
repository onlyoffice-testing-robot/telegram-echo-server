require 'spec_helper'
describe TelegramEchoServer::SinatraPostToRedis do
  it 'should allow send post notification' do
    post '/', notification: 'hello rspec'

    expect(last_response.status).to eq 200
  end

  it 'should not allow send other post' do
    post '/', stuff: 'hello rspec'

    expect(last_response.status).to eq 400
  end

  it 'sucessfull get data from redis' do
    queue = Redis::Queue.new('payload_queue',
                             'bp_payload_queue',
                             redis: Redis.new)
    expect(queue.pop).to eq('hello rspec')
  end
end
