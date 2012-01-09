class User

  cattr_accessor :clients

  def self.send_to_all(msg)
    @@clients ||= []
    @@clients.each do |c|
      c.send msg
    end
  end
end
