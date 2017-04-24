require 'telegram/bot'
require 'yaml'
require_relative 'server/queue'

# Main thread
module TelegramEchoServer
  config = YAML.load_file('../../../config.yml')
  Queue.add('Hi')
  Queue.add('My')
  Queue.add('Name')
  Queue.add('Bot')

  Telegram::Bot::Client.run(config['telegram_bot_token']) do |bot|
    loop do
      if Queue.empty?
        sleep 60
        next
      end
      bot.api.send_message(chat_id: config['chat_id'],
                           text: Queue.pop,
                           parse_mode: 'Markdown')
    end
  end
end
