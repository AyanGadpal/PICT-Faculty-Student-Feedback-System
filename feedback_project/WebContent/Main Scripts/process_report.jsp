<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,javax.sql.*"%>

<%
 		// Last Author : Ayan Gadpal
		Class.forName("com.mysql.jdbc.Driver");
		String database = (String)session.getAttribute("curdb");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+database, "Deva", "dev123456");
        Statement st=conn.createStatement();
        Statement st1=conn.createStatement();
        
        String div =(String)session.getAttribute("select_div");
        String year =(String)session.getAttribute("select_year");
        String teacher = (String)session.getAttribute("select_teacher");
        String subject = request.getParameter("select_subject");
        String cat_id = " ";
        String domain_name = "";
        int nostud = 1;
        
        
        String selectQuery = "select cat_id from teacher_class_subject where tid="+teacher+" and cid_year='"+year+"' and cid_div ="+div+" and sid="+subject;
        ResultSet rs = st.executeQuery(selectQuery);
        
        if(rs.next())
			cat_id = rs.getString("cat_id");
        	
		selectQuery = "select name from teachers where id="+teacher;
		rs = st.executeQuery(selectQuery);
		
        if(rs.next())
			teacher = rs.getString("name");
        
		selectQuery = "select subject_name,domain_name from subject where subject_id = "+subject;	
		rs = st.executeQuery(selectQuery);
         if(rs.next())
        {
        	domain_name = rs.getString("domain_name");
        }
        selectQuery = "select Count(DISTINCT(rollno)) as Count from studcheck where fc=1 and year = '"+year+"' and sid='"+subject+"' and division="+div;
        rs = st.executeQuery(selectQuery);	
		rs.next();
		int Count = rs.getInt("Count");
		out.println("Count : "+Count);
	//	out.println("Year : "+year);	
	//	out.println("SID : "+subject);	
	//	out.println("Division : "+div);	
	//	out.println("COUNT : "+Count);	
		
/* 		selectQuery = "select ran1,ran2 from class where year='"+year+"' and division="+div; */
		
        
/*         if(rs.next()){
			int r1 = rs.getInt("ran1");
			int r2 = rs.getInt("ran2");
			nostud = r2-r1;
			//System.out.println("++++++++++++++"+nostud);
        } */
        int total = 0;
%>

<script src="/1st_increment_feedback/js/jquery.js"></script>
	
	<script>
		function check(){
			  window.print()	
			  /* var pdf = new jsPDF();
			  pdf.addHTML($("body"), 5, 5, function() {
			    pdf.save('page.pdf');
			  });*/
			  } 
	</script>		
	
<body>
<% 
String Sem;
if(database.split("_",-2)[4].equals("sem1"))
	Sem = "1";
else
	Sem = "2";
%>
	<img src="theme-assets/images/logo/pict.jpg" style="height:120px;"/>
	<h1>PICT FEEDBACK REPORT</h1>
	<hr>
	<label><b>Name of staff : </b></label><label> <%= teacher %></label><br>
	<label><b>Academic Year : </b><%=database.split("_",-2)[2] +"-"+ database.split("_",-2)[3] %></label><br>
	<label><b>Semester :</b> <%=Sem%> </label><br>
	<label><b>Class : </b></label><label> <%= year %> <%= div %> </label><br>
	<label><b>Subject : </b></label><label> <%= subject %></label><br>
	
	<%
	selectQuery = "select qid,score from feedback where cat_id="+cat_id;
	rs = st.executeQuery(selectQuery);
	float pre = 0;
    float scoreTotal = 0;
	int TotScore = 0;	 
    int count=0;
	for(int i=1;rs.next();i++){ 
		int qid = rs.getInt("qid");
		selectQuery = "select * from question where qid="+qid;
		ResultSet rs1 = st1.executeQuery(selectQuery);
		selectQuery = "select * from feedback where qid="+qid+" and cat_id="+cat_id;
		String qname = " ";
		int score = 0;
		if(rs1.next())
		{
			qname = rs1.getString("question");
			rs1 = st1.executeQuery(selectQuery);
			rs1.next();
			score = rs1.getInt("score");
			scoreTotal =100*((float)score/(float)(Count*50));
			TotScore+=score;
			pre+=scoreTotal;
			count++;
		}
	}
	%>
	<label><b>Marks : <%=TotScore%>/<%=count*Count*50 %> </b></label><br>
	<label><b>Percentage : <%=pre/count %> %</b></label>
	<table width="90%" border="1">
		<thead>
           <tr>
               <th>Q.NO</th>
               <th>Question</th>
               <th>Score</th>
           </tr>
        </thead>
        <tbody>
        <%
        selectQuery = "select qid,score from feedback where cat_id="+cat_id;
        
    	
        rs = st.executeQuery(selectQuery);
    	int i;
    	System.out.println("CAT ID : "+cat_id);
    	for(i=1;rs.next();i++){ 
    		int qid = rs.getInt("qid");
    		selectQuery = "select * from question where qid="+qid;
    		ResultSet rs1 = st1.executeQuery(selectQuery);
    		selectQuery = "select * from feedback where qid="+qid+" and cat_id="+cat_id;
    		String qname = " ";
    		int score = 0;
    		if(rs1.next())
    		{
    			qname = rs1.getString("question");
    			rs1 = st1.executeQuery(selectQuery);
    			rs1.next();
    			score = rs1.getInt("score");
    			System.out.println("Question : "+qname);
    			System.out.println("Score : "+score/Count*50);
    	%>
        	<tr>
        		<th><%=i%></th>
        		<th><%=qname%></th>
        		<% scoreTotal =100*((float)score/(float)(Count*50));
        		%>
				<th><%=scoreTotal%> %</th>
        	</tr>
        <%}} %>
        </tbody>
	</table>
	<br>
	
	<button id="cmd" onclick="check()">Download PDF</button>
</body>
