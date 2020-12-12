<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="jclass.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<script>
	var a = 2
	var title_name = "Class"
</script>

<%@ include file = "navbar.jsp" %>

<p><% if(request.getParameter("error")!=null) out.print(request.getParameter("error"));%></p>

<form name="form1" action="Class.jsp" method="post">

<center>
		<label>YEAR OF ENGINEERING :</label>
        <select required name=year>
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
<center><label>Dept :&nbsp;</label><select required name="dept">
									<option value=""></option>
									 <option value="CS">C.S.</option>
          							<option value="IT">I.T.</option>
          							<option value="EnTC">ENTC</option>
									<option value="AS">A.S.</option>

</select><br><br></center>
<center><label>RANGE :&nbsp;</label><input id="range1" type="number" required placeholder="RANGE OF STUDENTS" name="ran1" min="1"></input>&nbsp;TO <input id="range2" type="number" placeholder="RANGE OF STUDENTS" name="ran2" min="1"></input><br><br></center>
<center><input required type="submit" class="btn" name="ADD1" value="ADD"></input></center>

</form>

<%
String year=null;
String division=null;
String dept=null;
String range1=null;
String range2=null;
String s=null;
String d=null;
Class.forName("com.mysql.jdbc.Driver");
String database = (String)session.getAttribute("curdb");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+database,"Deva","dev123456");
System.out.println("in class : "+database);
year=request.getParameter("year");
division=request.getParameter("div");
dept=request.getParameter("dept");
range1=request.getParameter("ran1");
range2=request.getParameter("ran2");
s=(String)request.getParameter("ADD1");
d=(String)request.getParameter("DELETE1");
Statement st1 = con.createStatement();
Statement st2 = con.createStatement();
ResultSet rs1;
if(request.getParameter("error")!=null)
{
	%>
    <p style="color:#FF0000"><%out.print("INVALID INPUT!");%></p>
    <%	
}
try
{
	if((year !="") && (division !=null) && (dept !="") && ((Integer.parseInt(range1))<(Integer.parseInt(range2))) && (s!=null))
	{

		try{
			st1.executeUpdate("insert into class values('"+year+"',"+division+",'"+dept+"',"+range1+","+range2+")");
			//trigger1
			for(int v=Integer.parseInt(range1); v<=Integer.parseInt(range2); v++){
				st1.executeUpdate("insert into student(rollno, year, division) values("+v+",'"+year+"',"+division+")"); 	
			}			
			out.println("CLASS ADDED");
			%>
		    <p style="color:#0000FF"><%out.println("CLASS ADDED");%></p>
		    <%
		}
		catch(SQLException e){
			st2.executeUpdate("delete from student where year='"+year+"' and division="+division+";");
			st2.executeUpdate("delete from class where division="+division+";");
			%>
		    <p style="color:#FF0000"><%out.print("INVALID RollNo Range "+e.getMessage());%></p>
		    <%			
		}
	}
	
	else if((year!="")&&(division!=null)&&(dept!="")&&(range1!=null)&&(d!=null))
	{
		//trigger 2
		st2.executeUpdate("delete from class where division="+division+";");
		//for(int v=Integer.parseInt(range1); v<=Integer.parseInt(range2); v++){
		st2.executeUpdate("delete from student where year='"+year+"' and division="+division+";"); 	
		//}
		out.println("CLASS DELETED");
	}
	
}
catch(Exception e)
{
	%>
    <p style="color:#FF0000"><%out.print("INVALID INPUT! "+e.getMessage());%></p>
    <%	          
}
%>
<br><br>
<center>
<form action="#" method=post>
			<input type="submit" class="btn" name="delete" value="Delete"/>
				<%
					if (request.getParameter("delete") != null) {
						sammdao obj = new sammdao();
						
						String[] arr = (String[]) request.getParameterValues("selected");
						obj.classdel(arr, database);
					}
				if(request.getParameter("error")!=null)
				{
					%>
					
					<p>*UPDATE FAILED DUE TO INCONSISTENCY IN DATA</p>
					<%
				}
				%>

<div class="table-responsive">
<table class="table">
   <tr>
		<th>Delete</th>   
        <th>YEAR</th>
        <th>DIVISION</th>
        <th>DEPT</th>
        <th>FROM</th>
        <th>TO</th>
        <th>Edit</th>
   </tr>
   
<% 
ResultSet rs2= st2.executeQuery("select * from class");
out.println("\n");
int i = 0;
while(rs2.next())
{
%>
	<tr>
		<td><input style="width:70px;" type="checkbox" name="selected" value='<%=rs2.getString(1)%>#<%=rs2.getInt(2)%>'/></td>
  		<td><input style="width:70px;" type="text" disabled="true" id="<%=i+rs2.getString(1)%>" value="<%=rs2.getString(1)%>"/></td>
  		<td><input style="width:70px;" type="text" disabled="true" id="<%=i+rs2.getString(2)%>" value="<%=rs2.getString(2)%>"/></td>
  		<td><input style="width:70px;" type="text" disabled="true" id="<%=i+rs2.getString(3)%>" value="<%=rs2.getString(3)%>"/></td>
  		<td><input style="width:80px;" type="text" disabled="true" id="<%=i+rs2.getString(4)%>" value="<%=rs2.getString(4)%>"/></td>
  		<td><input style="width:90px;" type="text" disabled="true" id="<%=i+rs2.getString(5)%>" value="<%=rs2.getString(5)%>"/></td>
  		<td><input style="width:90px;" type="button"  class="btn" onclick="fun1(this,'<%=i+rs2.getString(1)%>','<%=i+rs2.getString(2)%>','<%=i+rs2.getString(3)%>','<%=i+rs2.getString(4)%>','<%=i+rs2.getString(5)%>')" value="EDIT"/></td>
  	</tr>
<% 
	i++;
}
%>
</center>
</table>
</div>
</form>
<%@ include file = "downbar.jsp" %>
<script>
var prev = []
var oyear = null
var odiv = null
function fun1(el,el_id1,el_id2,el_id3,el_id4,el_id5){
	if(el.value == "UPDATE"){
		var year = document.getElementById(el_id1).value
		var div = document.getElementById(el_id2).value
		var dept = document.getElementById(el_id3).value
		var ran1 = document.getElementById(el_id4).value
		var ran2 = document.getElementById(el_id5).value
		
		var urlstr = "edits/ClassEdit.jsp?oyear="+ oyear +"&odiv="+ odiv+"&year="+ year+"&div="+ div+"&dept="+ dept+"&ran1="+ ran1+"&ran2="+ ran2
		window.location.replace(urlstr)
		el.value = 'EDIT'
		
		for(var i; i < prev.length; i++)
			prev[i].disabled = true
			
		oyear = null
		odiv = null
	}
	else{	
		if(prev.length != 0){
			for(var i; i < prev.length; i++)
				prev[i].disabled = true	
		}
		oyear = document.getElementById(el_id1).value
		odiv = document.getElementById(el_id2).value
	
		var cur = []
			
		cur.push(document.getElementById(el_id1))
		cur.push(document.getElementById(el_id2))
		cur.push(document.getElementById(el_id3))
		cur.push(document.getElementById(el_id4))
		cur.push(document.getElementById(el_id5))
		for(var i=0; i < cur.length; i++){
			cur[i].disabled = false
		}
		
		el.value = "UPDATE"
		
		for(var i=0; i < cur.length; i++)
			prev.push(cur[i])
	}
}
</script>
