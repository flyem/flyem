$(document).ready(function(){
    console.log("Starting up");
    var ws = new WebSocket("ws://localhost:9090/xxx");
    console.log("We have ws");
    console.log(ws);
    ws.onmessage = function(evt) { $("#chat_messages").append("<p>"+evt.data+"</p>"); };
    ws.onclose = function() { console.log("socket closed"); };
    ws.onopen = function() {
        console.log("connected...");
        ws.send(JSON.stringify({type: 'login', username: $.url().attr('query')}));
    };
    ws.onerror = function() {console.log("error")};
    $('#send').submit(function() {
        var sendMsg = $('#sendmsg')
        console.log("clicked")
        ws.send(sendMsg[0].value);
        sendMsg[0].value = ""
        return false;
    });
});
$(document).ready(function(){
   window.fbAsyncInit = function() {
      FB.init({
        appId      : '334624246557418',
        status     : true,
        cookie     : true,
        xfbml      : true,
        oauth      : true,
      });
    FB.Event.subscribe('auth.login',
        function(response) {
          alert('userid' + response.authResponse.userID);

          FB.api('/me', function(response) {
            alert(response.name);
          });
        });
    };
   (function(d){
      var js, id = 'facebook-jssdk'; if (d.getElementById(id)) {return;}
      js = d.createElement('script'); js.id = id; js.async = true;
      js.src = "//connect.facebook.net/en_US/all.js";
      d.getElementsByTagName('head')[0].appendChild(js);

    }(document));
});
