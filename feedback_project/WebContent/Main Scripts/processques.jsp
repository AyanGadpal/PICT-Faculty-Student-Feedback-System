<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%
	// Initialize database connection parameters

	try {
		String driver = "com.mysql.jdbc.Driver";
		String connectionUrl = "jdbc:mysql://localhost:3306/";
		String database = (String) session.getAttribute("curdb");
		String userid = "Deva";
		String password = "dev123456";
		Class.forName(driver);
		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;
		int maxid = 0;
		String tempid = "";

		// get parameters from the previous page
		String temp_name = request.getParameter("temp_name");
		String question = request.getParameter("question");
		String option1 = request.getParameter("option1");
		String option2 = request.getParameter("option2");
		String option3 = request.getParameter("option3");
		String option4 = request.getParameter("option4");
		String option5 = request.getParameter("option5");

		connection = DriverManager.getConnection(connectionUrl + database, userid, password);
		statement = connection.createStatement();

		// Get the max ques_id
		String sql = "select max(qid) as mqid from question";
		resultSet = statement.executeQuery(sql);
		if (resultSet.next()) {
			String temp = resultSet.getString("mqid");
			if (temp != null)
				maxid = Integer.parseInt(temp);
			else
				maxid = 0;
		} else
			maxid = 0;

		// Insert into the question table
		sql = "insert into question values ('" + question + "','" + option1 + "','" + option2 + "','" + option3
				+ "','" + option4 + "','" + (maxid + 1) + "','" + option5 + "')";
		statement.executeUpdate(sql);

		// Insert into the temp_ques mapping
		sql = "insert into temp_ques values ('" + temp_name + "'," + (maxid + 1) + ")";
		statement.executeUpdate(sql);

		connection.close();

		response.sendRedirect("addquestion.jsp?status=Question Added sucessfully&select_temp=" + temp_name);

	} catch (Exception e) {
		System.out.println(e.getMessage());
		response.sendRedirect("addquestion.jsp");
	}
%>
