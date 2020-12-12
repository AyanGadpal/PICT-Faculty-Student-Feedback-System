<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>


<html>

<head>
  <link rel="stylesheet" href="Login.css">
  <link href="https://fonts.googleapis.com/css?family=Ubuntu" rel="stylesheet">
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
  <title>PICT Feedback System</title>
  <script>
    
    var error = '<%=session.getAttribute("error")%>';

    if(error.trim().length != 0){
          alert(error);
     <%
        session.setAttribute("error"," ");
        session.setAttribute("user","");
     %> 
   }


  </script>
</head>

<body>
  <div class="main">
    <p class="sign" align="center">Sign in</p>
    <form class="form1" action="login.jsp" method="post"> 
      <input class="un " type="text" align="center" placeholder="Username" name="uname" autocomplete="off" required />
      <input class="pass" type="password" align="center" placeholder="Password" name="passwd" autocomplete="off" required />
      <select class="pass" name="select_year" id="select_year" align="center">
					</select> 
					<script>
						(function() {
						    var elm = document.getElementById('select_year'),
						        df = document.createDocumentFragment();
						    for (var i = (new Date().getFullYear())-10; i <= (new Date().getFullYear())+10; i++) {
						    	for(var j=1;j<=2;j++){
							        var option = document.createElement('option');
							        option.value = i + "_" + (i+1)+"_sem"+j;
							        option.appendChild(document.createTextNode(i+" _ "+(i+1)+"_sem"+j));
							        df.appendChild(option);
						    	}
						    }
						    elm.appendChild(df);
						}());
					</script>
					<br>
      <input type="submit" class="submit" value="Login"  />
      </form>      
                
    </div>
     
</body>

</html>

