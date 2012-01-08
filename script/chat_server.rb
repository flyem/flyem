class MyWebSocket < EventMachine::WebSocket::Connection
  def initialize
    super({})
  end

  cattr_accessor :clients
  
  def self.send_to_all(msg)
    @@clients ||= []
    @@clients.each do |c|
      c.send msg
    end
  end
end

EM.run do
  EventMachine.start_server("0.0.0.0", 9090, MyWebSocket) do |ws|
    ws.onopen do
      puts "New client"    
      ws.clients ||= []
      
      ws.clients.each do |c|
        c.send "We have a new client"
      end
    
      ws.clients << ws
      ws.send "Welcome friend"
    end

    ws.onmessage do |msg|
      puts "Message: #{msg}"

      

      p ws.clients.length
      ws.clients.each do |c|
        if c == ws
          c.send "You said #{msg}"
        else
          c.send "I heard #{msg}"
        end
      end
    end
      
    ws.onclose do |msg|
      puts "WebSocket closed"
      ws.clients.delete ws
      MyWebSocket.send_to_all "We lost a friend"
    end
  end
end
