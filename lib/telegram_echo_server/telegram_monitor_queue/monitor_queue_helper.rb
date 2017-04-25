module TelegramEchoServer
  # Helper to queue
  module MonitorQueueHelper
    def config
      YAML.load_file('config.yml')
    end

    def parse_chat_id(chat_name)
      config[chat_name]
    end

    def message_data(queue)
      message = JSON.parse(queue.pop)
      return nil if message['chat'].nil? || message['chat'].nil?
      { chat_id: parse_chat_id(message['chat']),
        text: message['notification'] }
    end
  end
end
