require 'bundler/setup'
Bundler.require

require 'goliath/websocket'

class Chat < Goliath::WebSocket
  include Goliath::Rack::Templates

  def on_open(env)
    env.logger.info("CHAT OPEN")
    env['subscription'] = env.channel.subscribe { |m| env.stream_send(m) }
  end

  def on_message(env, msg)
    env.logger.info("CHAT MESSAGE: #{msg}")
    env.channel << msg
  end

  def on_close(env)
    env.logger.info("CHAT CLOSE")
    env.channel.unsubscribe(env['subscription'])
  end

  def on_error(env, error)
    env.logger.error error
  end

  def response(env)
    if env['REQUEST_PATH'] == '/app.js'
      [200, {}, coffee(:app)]
    else
      [200, {}, haml(:index)]
    end
  end
end