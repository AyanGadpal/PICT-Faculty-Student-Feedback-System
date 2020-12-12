<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>    
<%@page import="jclass.*" %>

<%
// Initialize database connection parameters
String id = request.getParameter("userid");
String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String database = (String)session.getAttribute("curdb");
System.out.println("In Showpass");
String userid = "Deva";
String password = "dev123456";

String year2=null,div2=null;

try {
Class.forName(driver);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
String year=request.getParameter("select_year"),div=request.getParameter("select_div");
year2 = year;
div2 = div;

System.out.println(year2);
System.out.println(div2);
%>

<script>
	var a = 9
	var title_name = "Teacher Subject Class Mapping"
</script>
<%@ include file = "navbar.jsp" %>
<form method="post" action="#" name='myform' id="tsc">
		<label>Select Year</label>
		<select name="select_year" id="select_year" onchange="document.forms['myform'].submit();">
		<%
		try{
		    connection = DriverManager.getConnection(connectionUrl+database, userid, password);
		    statement=connection.createStatement();
		    String sql = "select distinct(year) as year1 from class";
		
		    resultSet = statement.executeQuery(sql);
		    while(resultSet.next()){
		    year2 = resultSet.getString("year1");
		%>
		  <option value="<%= year2 %>"><%= year2 %></option>    
		<%
		  }
		    connection.close();
		    }catch (Exception e) {
		    e.printStackTrace();
		    }
		%>

      </select>
      <label>Select Division</label>
	  <select name="select_div" id="select_div" onchange="document.forms['myform'].submit();">
			<%
			try{
			    connection = DriverManager.getConnection(connectionUrl+database, userid, password);
			    statement=connection.createStatement();
			    String sql = "select division from class where year='"+year+"'";
			
			    resultSet = statement.executeQuery(sql);
			    while(resultSet.next()){
			     div2 = resultSet.getString("division");
			%>
			<option value="<%= div2 %>"><%= div2 %></option>      
			<%
			  }
			    connection.close();
			    }catch (Exception e) {
			    e.printStackTrace();
			    }
			%>
      </select>
</form>
<form action="processpass.jsp" target="_blank">
	  <input type="hidden" name="my_year" value="<%= year%>"/>
	  <input type="hidden" name="my_div" value="<%= div%>"/>	
      <input type="submit" class="btn" name="add" value="Show Passwords"/>
</form>

<%@ include file = "downbar.jsp" %>

<script src="/1st_increment_feedback/js/jquery.js"></script>
<script>

$(document).ready(function(){
$("#select_year").val("<%= year%>")
$("#select_div").val("<%= div%>")
});
</script>
