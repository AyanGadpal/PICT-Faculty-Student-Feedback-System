<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>    
<%@page import="jclass.*"%>

<%
	// Initialize database connection parameters
	String id = request.getParameter("userid");
	String driver = "com.mysql.jdbc.Driver";
	String connectionUrl = "jdbc:mysql://localhost:3306/";
	String database = (String)session.getAttribute("curdb");
	//System.out.println("in add ques : "+database);
	String userid = "Deva";
	String password = "dev123456";
	
	try {
		Class.forName(driver);
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	}
	
	Connection connection = null;
	Statement statement = null;
	ResultSet resultSet = null;
	String status = "";
	String temp_name = request.getParameter("select_temp");
	System.out.println(temp_name);
	if(request.getParameter("status") != null)
		status = request.getParameter("status");
%>

<script>
	var a = 6
	var title_name = "Question Template"

		
		function check(){
			
			temp = $("#sel_tem").val();
			//var filename = document.getElementById("file").value();
			if(temp == null){
				alert('Please Select Template First');
				return false;
			}
			
			 filename = $("#file").val();
				
			 if(filename.trim().length == 0){
				 alert('Please Select The File To Upload Teachers Data');
				 return false;
			 }
			document.getElementById("add1").disabled = true;
			document.getElementById("add2").disabled = true;
			document.getElementById("del").disabled = true;
			
			return true;
		}
</script>
<%@ include file = "navbar.jsp" %>
	<center>
	<p style="color:#0000FF"><%= status %></p>
	<form method="post" action="/1st_increment_feedback/Main Scripts/addquestion.jsp" id="myform">
		<h1>Add Questions</h1>
		<label>Select name of the template</label>
		<select name="select_temp" id="sel_tem" onchange="document.forms['myform'].submit();">
		<%
			try{
		    		connection = DriverManager.getConnection(connectionUrl+database, userid, password);
		    		statement=connection.createStatement();
		    		String sql = "select temp_name from template";
					
		    		resultSet = statement.executeQuery(sql);
		    		while(resultSet.next()){
		    			String t_name = resultSet.getString("temp_name");
		%>
				   		<option value="<%= t_name %>"><%=t_name %></option>		    		
		<%
	  	 			}
	    			connection.close(); 
	    	 	}catch (Exception e) {
	    			e.printStackTrace();
	    		}
		%>
		
      	</select>
     </form>
     <p> Currently selected template - <b><%= temp_name %></b></p>
		
     </center>
     <br><br>
     <% 
     	if(request.getParameter("select_temp") != null)
     		temp_name = request.getParameter("select_temp");
		try{
	    		connection = DriverManager.getConnection(connectionUrl+database, userid, password);
	    		statement=connection.createStatement();		
	 %>
	<div class="row">
	<div class="col">	
     <form action="processques.jsp" method="post">
		<label>Enter the Question</label>
		<input size="60" pattern="^[a-zA-Z\s\.]+$" name="question" placeholder="Enter the Question" type="text" required/><br>
		<label>Option 1 (50 marks)</label>
		<input size="60" pattern="^[a-zA-Z\s\.]+$" name="option1" placeholder="option 1" type="text" required/><br>
		<label>Option 2 (40 marks)</label>
		<input size="60" pattern="^[a-zA-Z\s\.]+$" name="option2" placeholder="option 2" type="text" required/><br>
		<label>Option 3 (30 marks)</label>
		<input size="60" pattern="^[a-zA-Z\s\.]+$" name="option3" placeholder="option 3" type="text" required/><br>
		<label>Option 4 (20 marks)</label>
		<input size="60" pattern="^[a-zA-Z\s\.]+$" name="option4" placeholder="option 4" type="text" required/><br>
		<label>Option 5 (10 marks)</label>
		<input size="60" pattern="^[a-zA-Z\s\.]+$" name="option5" placeholder="option 5" type="text" required/><br>
		<input type="hidden" name="temp_name" value="<%= temp_name %>">  
			<br>
		<input type="submit" class="btn" id="add1" name="single" value="Add Question"/> 
	</form>
	</div>
	<div class="col">
			 
	 
	<h3>Choose Excel Sheet</h3>
	<br>
	<form action="que_upload.jsp" enctype="multipart/form-data" method="POST">
		<%
			session.setAttribute("tempID", temp_name);
		%>
		<input name="upload" id="file" class="form-control" type="file" accept=".xls, .xlsx">
		<br><br>
		<input type="submit" class="btn" id="add2" value="ADD" onclick="return check()">
	</form>
	
	 
	</div>
	</div>
    <form action="#" method=post>
	<br>

	<input type="submit" class="btn" id="del" name="delete" value="Delete"/>
		<%
			if (request.getParameter("delete") != null) {
				sammdao obj = new sammdao();
				
				String[] arr = (String[]) request.getParameterValues("selected");
				//String curdb = (String) session.getAttribute("curdb");
				obj.questiondel(arr, database);
			}
		%>
	<br>
	<div class="table-responsive">
		<table class="table" style="width:400px;">
	        <tr>
	        	<th style="width:20px;">Delete</th>
				<th style="width:20px;">Qid</th>
				<th style="width:20px;">question</th> 
				<th style="width:20px;">option1</th>
				<th style="width:20px;">option2</th>
				<th style="width:20px;">option3</th>
				<th style="width:20px;">option4</th>
				<th style="width:20px;">option5</th>
				<th>Edit</th>
			</tr>
			<%
	         resultSet = statement.executeQuery("select qid,question,option1,option2,option3,option4,option5 from question where qid in (select qid from temp_ques where temp_id ='"+ temp_name +"')");
			 int i = 0;
	         while(resultSet.next()){
	         %>
	         <tr>
		         <td><input style="width:20px;" type="checkbox" name="selected" value='<%=resultSet.getString("qid")%>'/></td>
		  		 <td><input style="width:50px;" type="text" disabled="true" id="<%=i+resultSet.getString("qid")%>" value="<%=resultSet.getString("qid")%>"/></td>
		  		 <td><input style="width:350px;" type="text" disabled="true" id="<%=i+resultSet.getString("question")%>" value="<%=resultSet.getString("question")%>"/></td>
		  		 <td><input style="width:80px;" type="text" disabled="true" id="<%=i+resultSet.getString("option1")%>" value="<%=resultSet.getString("option1")%>"/></td>
		  		 <td><input style="width:80px;" type="text" disabled="true" id="<%=i+resultSet.getString("option2")%>" value="<%=resultSet.getString("option2")%>"/></td>
		  		 <td><input style="width:80px;" type="text" disabled="true" id="<%=i+resultSet.getString("option3")%>" value="<%=resultSet.getString("option3")%>"/></td>
		  		 <td><input style="width:80px;" type="text" disabled="true" id="<%=i+resultSet.getString("option4")%>" value="<%=resultSet.getString("option4")%>"/></td>
		  		 <td><input style="width:80px;" type="text" disabled="true" id="<%=i+resultSet.getString("option5")%>" value="<%=resultSet.getString("option5")%>"/></td>
		  		 <td><input style="width:80px;" type="button" class="btn" onclick="fun1(this,'<%=i+resultSet.getString("qid")%>','<%=i+resultSet.getString("question")%>','<%=i+resultSet.getString("option1")%>','<%=i+resultSet.getString("option2")%>','<%=i+resultSet.getString("option3")%>','<%=i+resultSet.getString("option4")%>','<%=i+resultSet.getString("option5")%>')" value="EDIT"/></td>
		  	 </tr>
			<%
			i++;
			}	
			%>
		</table>  
    	<% 			
    			connection.close(); 
    	 	}catch (Exception e) {
    			e.printStackTrace();
    		}
	 	%>
	 </div>
	 </form>
<%@ include file = "downbar.jsp" %>
<script src="/1st_increment_feedback/js/jquery.js"></script>
<script>
	$(document).ready(function(){
		$("#sel_tem").val("<%= temp_name %>")
	});
</script>
<script>
var prev = []
var oqid = null

function fun1(el,el_id1,el_id2,el_id3,el_id4,el_id5,el_id6,el_id7){
	if(el.value == "UPDATE"){
		var qname = document.getElementById(el_id2).value
		var op1 = document.getElementById(el_id3).value
		var op2 = document.getElementById(el_id4).value
		var op3 = document.getElementById(el_id5).value
		var op4 = document.getElementById(el_id6).value
		var op5 = document.getElementById(el_id7).value
		
		var urlstr = "edits/questionEdit.jsp?oqid="+ oqid +"&qname="+ qname+"&op1="+ op1+"&op2="+ op2+"&op3="+ op3+"&op4="+ op4+"&op5="+op5
		window.location.replace(urlstr)
		el.value = 'EDIT'
		
		for(var i; i < prev.length; i++)
			prev[i].disabled = true
	}
	else{	
		if(prev.length != 0){
			for(var i; i < prev.length; i++)
				prev[i].disabled = true	
		}
		
		oqid = document.getElementById(el_id1).value
	
		var cur = []
			
		cur.push(document.getElementById(el_id2))
		cur.push(document.getElementById(el_id3))
		cur.push(document.getElementById(el_id4))
		cur.push(document.getElementById(el_id5))
		cur.push(document.getElementById(el_id6))
		cur.push(document.getElementById(el_id7))
		

		for(var i=0; i < cur.length; i++){
			cur[i].disabled = false
		}
		
		el.value = "UPDATE"
		
		for(var i=0; i < cur.length; i++)
			prev.push(cur[i])
	}
}
</script>
