<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>

<body>
	<div class="container">	
	<div class="col-md-5">
	    <div class="form-area">  
	        <form id="eleForm" role="form" action="twitter" method="post" style="width:150%;">        
	        	<h3 style="margin-bottom: 25px; text-align: center;"> Mohit Twitter </h3>    		    				        	               		 
				<div id="User_Pic"></div>
				<h6 id="User_Welcome"></h6>
				<nav class="navbar navbar-default">
				  <div class="container-fluid">    
				    <ul class="nav navbar-nav">
				      <li><a id="tweetLink">Tweet</a></li>
				      <li><a href="#">Friends</a></li>
				      <li><a href="/toptweets">Top Tweets</a></li>
				    </ul>
				  </div>				  
				</nav>	
				<h5 id="tt"></h5>			
			</form>		               
	    </div>
	</div>
	</div>
	<input type="hidden" id="author" name="author" value=">" >
	
	
	<script>
		var usertweets = '${usertweets}';
		debugger;
		console.log(usertweets);
		usertweets = usertweets.split("-----")
		for (var i = 0; i < usertweets.length-1; i++) {
			console.log(usertweets[i]);
			console.log(document.getElementById('tt').innerHTML);
			document.getElementById('tt').innerHTML = document.getElementById('tt').innerHTML +usertweets[i].split('--')[0]+'  ('+usertweets[i].split('--')[1]+'Visits)<br>';
			debugger;
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
						debugger;
						var welcomeBlock = document.getElementById('User_Welcome');
						welcomeBlock.innerHTML = 'Hello, ' + data.first_name+' '+ data.last_name + '!'+'<br/>'+"Welcome to the Application";
					    document.getElementById("tweetLink").href="/twitter?Author="+data.first_name + data.last_name; 
						var sndName= document.getElementById("author")
						if (sndName){
							console.log('The sender is ok ');
							sndName.value = data.first_name+' '+ data.last_name;
						}else{
							console.log('The sender is ok ');
						}
					});
				} else {
					var welcomeBlock = document.getElementById('fb-welcome');
					welcomeBlock.innerHTML = 'Cant get data ' + response.status + '!';
				}
			}
			debugger;
			FB.getLoginStatus(function(response) {								
				if (response.status == 'connected') {					
					onLogin(response);
				} else {					
					FB.login(function(response) {
						onLogin(response);
					}, {
						scope : 'user_friends, email, user_birthday'
					});
				}
			});

			console.log('logPageView .... ');
			FB.AppEvents.logPageView();

		};

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