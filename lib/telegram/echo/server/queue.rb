module TelegramEchoServer
  # Queue for storing messages to send
  class Queue
    @queue = []

    class << self
      attr_reader :queue

      def empty?
        queue.empty?
      end

      # @return [String] get latest item from queue, and delete it
      def pop
        return nil if empty?
        value = queue[0]
        queue.delete_at(0)
        value
      end

      # @param item [String] Item to add
      # @return [Nothing] add item to array
      def add(item)
        queue.push(item)
      end
    end
  end
end
