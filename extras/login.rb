class Login



  def action(ws, msg)
    usr = User(ws)
    User.add(usr)
    User.show_all_users_to(usr)
    usr.send("blah", channel)
  end
end
