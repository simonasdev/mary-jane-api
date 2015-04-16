require 'airborne'

describe 'API' do
  it 'should get ping-pong hash as a response' do
    get 'localhost:9292/ping'
    expect_json({ping: 'pong'})
  end
end
