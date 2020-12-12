<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	var a = 0
	var title_name = "Instructions"
</script>
<%@ include file = "navbar.jsp" %>

<p style="color:#FF0000;font-size:18px;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b> IMPORTANT INSTRUCTIONS </b></p>
<ul>
<li>Go through the sequence as given in the NavBar</li>
<li>Once all Entities as filled go for mapping screens</li>
<li>Once all mappings are done click on the button GENERATE PASSWORDS</li>
<li>To see passwords class-wise click on the button SHOW PASSWORDS</li>
<li>"GENERATE PASSWORDS" deletes pre-recorded feedback for this semester,<b> be careful with this!!</b></li> 
<li>To remove mappings, delete the mappings from Teacher_subject_class screen</li> 
<li>Options of a question should be unique</li>
<li>Give the random passwords to the students</li>
<li>Students will login from student side URL and give answers to the questions</li>
<li>Once students have given feedback you can generate reports of teachers in PDF format</li>
</ul>

<%
	String curdb = (String)session.getAttribute("curdb");
	//System.out.println("Attribute found "+curdb);	
	String status = "";
		
	if(request.getParameter("status") != null){
		if(!request.getParameter("status").isEmpty())
			status = request.getParameter("status");
	}
%>
<p style="color:#000000;font-size:22px;"><b><%=status %></b></p>

<form action="randompass.jsp">
	<input type="submit" class="btn"  value="GENERATE PASSWORDS"/>
</form>

<form action="showpass.jsp">
	<input type="submit" class="btn"  value="SHOW PASSWORDS"/>
</form>

<%@ include file = "downbar.jsp" %>