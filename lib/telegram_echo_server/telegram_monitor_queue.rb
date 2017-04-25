require 'telegram/bot'
require 'yaml'
require 'redis-queue'
require_relative 'telegram_monitor_queue/monitor_queue_helper'

module TelegramEchoServer
  # Class for post stuff to telegram bot
  class TelegramMonitorQueue
    extend MonitorQueueHelper

    def self.start
      queue = Redis::Queue.new('payload_queue',
                               'bp_payload_queue',
                               redis: Redis.new)
      Telegram::Bot::Client.run(config['telegram_bot_token']) do |bot|
        loop do
          message_data = message_data(queue)
          next if message_data.nil?
          bot.api.send_message(chat_id: message_data[:chat_id],
                               text: message_data[:text])
        end
      end
    end
  end
end
