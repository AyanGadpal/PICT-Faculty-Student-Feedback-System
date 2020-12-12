<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="jclass.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<script type="text/javascript">
var a=1;
</script>

<%@ include file = "navbar.jsp" %>

<p><% if(request.getParameter("error")!=null) out.print(request.getParameter("error"));%></p>

<form name="form1" action="showPass.jsp" method="post">

<center>
		<label>YEAR OF ENGINEERING :</label>
        <select name=year>
	        <option value=""></option>
	        <option value="FE">FE</option>
	        <option value="SE">SE</option>
	        <option value="TE">TE</option>
		    <option value="BE">BE</option>	
         </select>
         <br>
         <br>
</center>
          <center><label>Division :&nbsp;</label><input id="div" type="number" placeholder="Division" name="div" min="1" max="20"></input><br><br></center>
<center><input type="submit" name="genpass" value="Generate Password"></input></center>

</form>

