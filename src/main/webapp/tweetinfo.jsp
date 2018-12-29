

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Sonal App</title>
</head>
<body>

<div class="container">
<div class="col-md-5">
    <div class="form-area">  
        <form role="form" action="Tweet" method="post" style="width:150%;">        
        	<h3 style="margin-bottom: 25px; text-align: center;">Sonal App</h3>    		    				        	               		 
			<div id="User_Pic"></div>
			<h6 id="User_Welcome"></h6>
			<nav class="navbar navbar-default">
			  <div class="container-fluid">    
			    <ul class="nav navbar-nav">
			      <li><a href="#">Tweet</a></li>
			      <li><a href="#">Friends</a></li>
			      <li><a href="#">Top Tweets</a></li>
			    </ul>
			  </div>
			</nav>				
			
			<div class="form-group">						
				Tweet:  <p id="message" class="form-control"></p>				 
			</div>
			<div class="form-group">						
				Tweet Id:  <p id="ID" class="form-control"></p>				 
			</div>
			<div class="form-group">						
				Created By:  <p id="author" class="form-control"></p>				 
			</div>
			<div class="form-group">						
				Created On:  <p id="createdAt" class="form-control"></p>				 
			</div>
			<div class="form-group">						
				Visited Count:  <p id="visitedCount" class="form-control"></p>				 
			</div>								              
    </div>    
</div>
</div>
	 <script>
	 //console.log("Record Count = "+'');
	 document.getElementById("ID").innerHTML=''
	 document.getElementById("author").innerHTML=''
	 document.getElementById("message").innerHTML=''
	 document.getElementById("createdAt").innerHTML=''
	 document.getElementById("visitedCount").innerHTML=''
	</script>
</body>
</html>