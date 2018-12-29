<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Mohit Tweet</title>
</head>
<body>

<div class="container">
<div class="col-md-5">
    <div class="form-area">  
        <form role="form" action="twitter" method="post" style="width:150%;">        
        	<h3 style="margin-bottom: 25px; text-align: center;"> Mohit Twitter </h3>    		    				        	               		 
			<div id="User_Pic"></div>
			<h6 id="User_Welcome"></h6>
			<nav class="navbar navbar-default">
			  <div class="container-fluid">    
			    <ul class="nav navbar-nav">
			      <li><a href="#">Tweet</a></li>
			      <li><a href="#">Friends</a></li>
			      <li><a href="/toptweets">Top Tweets</a></li>
			    </ul>
			  </div>
			</nav>				
			<div class="form-group">
				<input type="text" class="form-control" id="txtPostTweet" name="txtPostTweet" placeholder="Tweet" style="width:80%;">
				<button type="submit" class="btn btn-primary" id="btnPost">Save</button><br>
			</div>											
			<select name="selectTweets" id="selectTweets" size="5"></select><br/>
			
			<input type="hidden" id="Author" name="Author" >
			<input type="hidden" id="sndName" name="sndName" value=">" ><br>
			
			<div class="btn-group" style="align-items: center;">
			  <button type="button" class="btn btn-default" onclick="viewTweetInfo();">Display Info</button>
			  <button type="button" class="btn btn-default" onclick="postToTimeLine()">Post to Timeline</button>
			  <button type="button" class="btn btn-default" onclick="SendMessageToFriend()">Send Message To Friend</button>
			  <button type="button" class="btn btn-default"
							onclick="removeTweet()">Delete Tweet</button>
			</div>		               
    </div>
</div>
</div>

<form action="twitter" method="post">
	</form>

<script>
	console.log('${sndName}');
	var usertweets = '${usertweets}';
	debugger;
	var myselect = document.getElementById('selectTweets');
	usertweets = usertweets.split("-----")
	for (var i = 0; i < usertweets.length-1; i++) {				
		var opt = document.createElement('option');
	    opt.value = usertweets[i].split('--')[0];
	    opt.innerHTML = usertweets[i].split('--')[1];
	    myselect.appendChild(opt);
	}

	window.fbAsyncInit = function() {
	FB.init({
		appId : '1321199734624625',
		xfbml : true,
		version : 'v2.9'
	});

	function onLogin(response) {
		if (response.status == 'connected') {
			FB.api('/me?fields=first_name,last_name', function(data) {
				var welcomeBlock = document.getElementById('User_Welcome');
				welcomeBlock.innerHTML = 'Hello, ' + data.first_name+' '+ data.last_name + '!'+'<br/>'+"Welcome to the Application";						
				document.getElementById("Author").value = data.first_name + data.last_name;											    
			});
		} else {
			var welcomeBlock = document.getElementById('User_Welcome');
			welcomeBlock.innerHTML = 'Cant get data ' + response.status + '!';
		}
	}
	FB.getLoginStatus(function(response) {
		// Check login status on load, and if the user is
		// already logged in, go directly to the welcome message.
		console.log('getLoginStatus .... ');
		if (response.status == 'connected') {
			console.log('connected .... ');
			onLogin(response);
		} 
		else {
			// Otherwise, show Login dialog first.
			console.log('Not connected .... ');
			FB.login(function(response) {onLogin(response);}, 
					{scope : 'user_friends, email, user_birthday'
			});
		}
	});
	console.log('logPageView .... ');
	FB.AppEvents.logPageView();
};

function viewTweetInfo() {
    window.open('https://1-dot-mytweetproject-168818.appspot.com/tweetinfo?id=' + myselect.options[myselect.selectedIndex].value 
    		, '_blank', 'toolbar=yes, location=yes, status=yes, menubar=yes, scrollbars=yes');
}

function postToTimeLine() {	
	//var mt = selectTweets.options[selectTweets.selectedIndex].innerHTML;
	var linkToPost = 'https://1-dot-mytweetproject-168818.appspot.com/tweetinfo?id=' + selectTweets.options[selectTweets.selectedIndex].value ;

	FB.login(function() {
				FB.api('/me/feed', 'post', {
					message : linkToPost
				});
				// Notification 
				// document.getElementById('confirmText').innerHTML = 'Thank You!' + mt;
	}, {scope : 'publish_actions'});
}

function SendMessageToFriend() {
	var linkToSend = 'https://1-dot-mytweetproject-168818.appspot.com/tweetinfo?id=' + selectTweets.options[selectTweets.selectedIndex].value ;
	FB.ui({
		app_id : '1321199734624625',
		method : 'send',
		link : linkToSend,
	});
}
function removeTweet(){
	selectTweets.options[selectTweets.selectedIndex].remove();
}


(function(d, s, id) {
	var js, fjs = d.getElementsByTagName(s)[0];
	if (d.getElementById(id)) {
		return;
	}
	js = d.createElement(s);
	js.id = id;
	js.src = "//connect.facebook.net/en_US/sdk.js";
	fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

</script>

</body>
</html>