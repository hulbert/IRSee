var fs = require('fs'),
	url = require('url'),
	path = require('path');
	
	





var server = require('http').createServer(function(req, res){
	var url_parts = url.parse(req.url);
	
	function getTemplate(template_name) {
		try {
			return fs.readFileSync(__dirname + '/templates/' + template_name + '.tpl');
		} catch (e) {
			console.log('templating problem: ', e);
		}
	}
	
	// check if in asset folder
	if (url_parts.pathname.indexOf('/assets/') == 0) {
		switch (path.extname(url_parts.pathname)) {
			case '.html':
				contentType = 'text/html';
				break;
			case '.js':
				contentType = 'text/javascript';
				break;
			case '.css':
				contentType = 'text/css';
				break;
			default:
				contentType = 'text/html';
				break;
		}
		var filePath = __dirname + url_parts.pathname;
		path.exists(filePath, function(exists) {
			if (exists) {
				fs.readFile(filePath, function(error, content) {
					if (error) {
						res.writeHead(500);
						res.end();
					}
					else {
						res.writeHead(200, { 'Content-Type': contentType });
						res.end(content, 'utf-8');
					}
				});
			}
			else {
				res.writeHead(404);
				res.end();
			}
		})
	} else {
		// basic URL routing with switch
		switch(url_parts.pathname) {
		case '/':
			res.end(getTemplate('index'));
			break;
		default:
			res.writeHead(404, {'Content-Type': 'text/html'});
			res.end(getTemplate('404'));
		}
	}
	

	
	
	
	

		
	
});

server.listen(8080);





var nowjs = require("now");
var everyone = nowjs.initialize(server);




everyone.now.distributeMessage = function(message) {
	everyone.now.getMessage(this.now.name, message);
};