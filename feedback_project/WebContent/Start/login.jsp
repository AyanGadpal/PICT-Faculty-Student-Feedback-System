<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%
	String uname = request.getParameter("uname");
	String pass = request.getParameter("passwd");
	String year = request.getParameter("select_year");
	System.out.println(year);
	try{
		Class.forName("com.mysql.jdbc.Driver");
		
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/feedback_main","Deva","dev123456");
		Connection con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/","Deva","dev123456");
		Statement st2 = con2.createStatement();			
		
		String query = "select pass from accounts where name='"+uname+"'";
		
		Statement st = con.createStatement();
		ResultSet resultSet = st.executeQuery(query);
		
		int res = -1;
		ResultSet rset = null;
		String curdb = "";
		
		////
		ResultSet rs2 = null;
		Statement s2 = con2.createStatement();
		////
		if(resultSet.next())
		{
			if(pass.equals(resultSet.getString("pass")))
			{
				rs2 = s2.executeQuery("SHOW DATABASES like '%feedback_main_"+year+"'");
				if(rs2 != null)
				{
					if(rs2.next())
					{
						res = st2.executeUpdate("USE feedback_main_"+year);					
						System.out.println("Value of rs is : "+res);
						if(res != -1)
						{
							rset = st2.executeQuery("Select database()");
							while(rset.next())
							{
								curdb = rset.getString(1);
								System.out.println("Database in use is " + curdb);
							}
							response.sendRedirect("/1st_increment_feedback/Main Scripts/ins.jsp?"+curdb);
							session.setAttribute("curdb", curdb);
							rset.close();
						}
					}
					else
					{
						response.sendRedirect("Login.html?error= selected db does not exist");
					}
					rs2.close();
				}
				else
					response.sendRedirect("Login.html?error= selected db does not exist");
			}
			else
				response.sendRedirect("Login.html?error=Password or Username is Wrong");
			}	
		else
				response.sendRedirect("Login.html?error=No user with user Name");
	
		
		st.close();
		st2.close();
		resultSet.close();
		con.close();
	
	}catch(Exception e){
		e.printStackTrace();
	}
%>
