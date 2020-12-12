<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>

<form action="temp.jsp" method="post" name="myDBForm">
		<label>Select Year</label> 
		<!-- <select name="select_year" id="select_year"></select> -->
		<script>
			var select = document.createElement("select");
			select.id = "select_db_year";
			select.name = "select_db_year";
			//select.onchange = "document.forms['myDBForm'].submit();"
			var date = new Date();
			var year = date.getFullYear();
			for (var i = year - 4; i <= year; i++) {
			  	var option = document.createElement('option');
			  	option.value = option.innerHTML = i;
			  	//if (i === year) option.selected = true;
			  	select.appendChild(option);
			}
			document.body.appendChild(select);
		</script>		
		
		<input type="submit" name="Create" value="Create"> 
		<input type="submit" name="Drop" value="Drop"> 
		<input type="submit" name="Use" value="Use">
		<input type="reset" name="Reset" value="Reset">
</form>

<script src="/1st_increment_feedback/js/jquery.js"></script>
<script>
</script>