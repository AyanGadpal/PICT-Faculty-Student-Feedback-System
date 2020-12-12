<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="jclass.*"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="theme-assets/css/vendors.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String year=null;
String division=null;

Class.forName("com.mysql.jdbc.Driver");
String database = (String)session.getAttribute("curdb");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+database,"Deva","dev123456");
year=request.getParameter("my_year");
division=request.getParameter("my_div");
Statement st1 = con.createStatement();
ResultSet rs2;
if(request.getParameter("error")!=null)
{
	%>
    <p style="color:#FF0000"><%out.print("INVALID INPUT!");%></p>
    <%	
}
try
{
	if((year !="") && (division !=null) )
	{
		rs2 = st1.executeQuery("select rollno,pass from student where year='"+year+"' and division='"+division+"'");	          
		System.out.println(year);
		System.out.println(division);
			%>
			
		<div class="table-responsive">
		<table class="table">
		<tr>
		<th>Roll no</th>   
		<th>Password</th>
		</tr>
		
		<% 
		out.println("\n");
		int i = 0;
		while(rs2.next())
		{
		%>
		<tr>
			<td><%=rs2.getString(1)%></td>
			<td><%=rs2.getString(2)%></td>
		</tr>
		<% 
		i++;
		}
		%>
		</center>
		</table>
		</div>
		<%
	}
}
catch(SQLException e)
{
	System.out.println(e.getMessage());	
	%>
    <p style="color:#FF0000"><%out.print("INVALID INPUT!");%></p>
    <%	          
}

%>
</body>
</html>