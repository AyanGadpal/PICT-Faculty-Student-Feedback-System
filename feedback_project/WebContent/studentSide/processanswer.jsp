<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%> 
<META http-equiv="refresh" content="1;URL=index.jsp">
<% 

// Initialize database connection parameters
String id = request.getParameter("userid");
String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String database = (String)session.getAttribute("database");
String userid = "Deva";
String password = "dev123456";

try {
	Class.forName(driver);
} catch (ClassNotFoundException e) {
	e.printStackTrace();
}

int flag = 0;
Connection con = null;

Class.forName("com.mysql.jdbc.Driver");
con = DriverManager.getConnection(connectionUrl+database, userid, password);
Statement st2=con.createStatement();
System.out.print(request.getParameter("subid"));
String sid=request.getParameter("subid");
String tid = request.getParameter("tid");
String rid = request.getParameter("rid");
st2.executeUpdate("update studcheck set fc=1 where sid="+sid+" and rollno="+rid+";");
st2.executeUpdate("update student_cat set fc=1 where tid="+tid+" and sid="+sid+" and rollno="+rid+";");
ResultSet rs2 = st2.executeQuery("select qid from temp_ques where temp_id in(select temp_id from teacher_subject_template where tid="+request.getParameter("tid")+" and sid="+request.getParameter("subid")+" )");
for(int i=0;i < Integer.parseInt(request.getParameter("total"));i++)
{
	Statement st = con.createStatement();
	Statement st1 = con.createStatement();
	rs2.next();
	int val= rs2.getInt("qid");
	//System.out.println(Integer.toString(i+1));
	ResultSet rs = st.executeQuery("select * from feedback where cat_id = "+request.getParameter("cat")+" and qid ="+val);
	
	st.executeUpdate("update feedback set score=score+"+Integer.parseInt(request.getParameter(Integer.toString(i+1)))+"  where cat_id = "+request.getParameter("cat")+" and qid ="+val);
}
response.sendRedirect("index.jsp?uname="+rid);
%>
