class MyWebSocket < EventMachine::WebSocket::Connection
  include JSONWebSocket
  def initialize
    super({})
  end
end

EM.run do
  EventMachine.start_server("0.0.0.0", 9090, MyWebSocket) do |ws|
    ws.onopen do
      puts "New client"    
      User.clients ||= []
      
      User.clients.each do |c|
        c.send "We have a new client"
      end
    
      User.clients << ws
      ws.send "Welcome friend"
    end

    ws.onmessage do |msg|
      # if msg['type'] == 'login' new Login(ws).action(msg)
      User.clients.each do |c|
        if c == ws
          c.send "You said #{msg}"
        else
          c.send "I heard #{msg}"
        end
      end
    end
      
    ws.onclose do |msg|
      puts "WebSocket closed"
      User.clients.delete ws
      User.send_to_all "We lost a friend"
    end
  end
end
