var express = require('express')
 , http = require('http');
var bodyParser = require('body-parser');

var app = express();

app.use(bodyParser.json());                        
app.use(bodyParser.urlencoded({ extended: true }));

app.post('/data',function(request,response,next){

    console.log(JSON.stringify(request.body));
    response.end(0);

} );


http.createServer(app).listen( process.env.PORT || 3000, function(){
 console.log('Express server listening on port ' + (process.env.PORT || 3000));
});