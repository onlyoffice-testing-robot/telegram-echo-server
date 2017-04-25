module TelegramEchoServer
  # Helper modules for sinatra
  module SinatraHelper
    # Ignore all params only allowed
    # @param params [Hash] all params of query
    # @return [Hash] allowed params
    def strong_params(params)
      hash = { notification: params[:notification] }
      hash[:chat] = params[:chat]
      hash
    end
  end
end
