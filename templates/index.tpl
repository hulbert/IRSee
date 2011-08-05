<!DOCTYPE html>
<html lang="en">
<head>
	<title>nowjs test</title>
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>
	<script src="/nowjs/now.js"></script>
	
	<link rel="stylesheet" href="/assets/css/master.css">
	<script>
	$(document).ready(function(){
		// common DOM lookups
		var $chat_box = $('#text_input');

		// initiate:
		$('.screen').hide();
		$('#splash_screen').show();

		
		
		
		// actions that will occur
		function submitMessage(isCodeSubmit) {
			console.log('submitMessage run')
			if ($chat_box.val().trim() !== '') {
				now.distributeMessage($chat_box.val());
			}
			$chat_box[0].value = '';
		}

		now.getMessage = function(name, message, type){
			var $newline = $('<div class="message message-chat"></div>');
			$('<span class="username">').html(name).appendTo($newline);
			$('<span class="message-body" style="white-space: pre;">').html(message).appendTo($newline);
			// $newline.append('<span class="message-body">').html(message);
			// <span class="username"></span> <span class="message-body"></span>
			
			$("#messages").append($newline);
		}
		
		
		
		
		// binding/monitoring
		$("#chat_form").submit( function(e) {
			e.preventDefault();
			submitMessage();
		});
		

		$('#enter_name').submit( function(e) {
			e.preventDefault();
			now.name = $(this).find('input[type=text]').val();
			$('#splash_screen').hide();
			$('#chat_screen').show();
		});
		
		$('#text_input').bind('keydown', function(e) {
			if (e.metaKey && e.keyCode == 13) {
				e.preventDefault();
				submitMessage(true);
			} else if (e.shiftKey || e.ctrlKey || e.altKey) {
				// do nothing so I can still type option + enter to add line breaks
				
			} else if (e.keyCode == 13) {
				e.preventDefault();
				submitMessage();
			}
		})
		
	});
	</script>
</head>


<body>
	
	<div id="wrapper">
	
		<div id="splash_screen" class="screen">
			<div id="nameform">
				<form id="enter_name" action="/">
					<label>Please enter your name: <input type="text" autofocus></label>
				</form>
			</div>
		</div>
	
		<div id="chat_screen" class="screen">
			<div id="messages"></div>
		
			<form id="chat_form" action="/">
				<textarea id="text_input"></textarea>
				<input type="button" value="Send" id="send-button">
			</form>
		
		</div>
	
	</div>
	
</body>
</html>