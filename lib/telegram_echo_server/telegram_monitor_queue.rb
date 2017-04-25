require 'telegram/bot'
require 'yaml'
require 'redis-queue'
module TelegramEchoServer
  # Class for post stuff to telegram bot
  class TelegramMonitorQueue
    def self.config
      YAML.load_file('config.yml')
    end

    def self.start
      queue = Redis::Queue.new('payload_queue',
                               'bp_payload_queue',
                               redis: Redis.new)
      Telegram::Bot::Client.run(config['telegram_bot_token']) do |bot|
        loop do
          bot.api.send_message(chat_id: config['chat_id'],
                               text: queue.pop['notification'])
        end
      end
    end
  end
end
