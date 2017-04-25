require 'spec_helper'
describe 'SinatraPostToRedis' do
  it 'should allow send post notification' do
    post '/', notification: 'hello rspec'

    expect(last_response.status).to eq 200
  end

  it 'should allow post with two params' do
    post '/', notification: 'hello rspec2', chat: 'qa_chat'
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
    queue_data = JSON.parse(queue.pop)
    expect(queue_data['notification']).to eq('hello rspec')
    expect(queue_data['chat']).to be_nil

    queue_data = JSON.parse(queue.pop)
    expect(queue_data['notification']).to eq('hello rspec2')
    expect(queue_data['chat']).to eq('qa_chat')
  end
end
