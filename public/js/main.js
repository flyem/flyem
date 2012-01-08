$(document).ready(function(){
    console.log("Starting up");
    var ws = new WebSocket("ws://localhost:9090/xxx");
    console.log("We have ws");
    console.log(ws);
    ws.onmessage = function(evt) { $("#chat_messages").append("<p>"+evt.data+"</p>"); };
    ws.onclose = function() { console.log("socket closed"); };
    ws.onopen = function() {
        console.log("connected...");
        ws.send({{login: }});
    };
    ws.onerror = function() {console.log("error")};
    $('#sendbtn').click(function() {
        console.log("clicked")
        ws.send($('#sendmsg')[0].value);
    });
});
