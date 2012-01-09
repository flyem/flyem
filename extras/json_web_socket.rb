module JSONWebSocket

  def trigger_on_message(msg)
    p msg
    parsed_msg = JSON.parse(msg)
    super(parsed_msg)
  end

end
