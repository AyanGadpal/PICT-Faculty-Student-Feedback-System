<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>   
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>    

<%
	// Initialize database connection parameters
	String id = request.getParameter("userid");
	String driver = "com.mysql.jdbc.Driver";
	String connectionUrl = "jdbc:mysql://localhost:3306/";
	String database = (String)session.getAttribute("database");
	String userid = "Deva";
	String password = "dev123456";
	System.out.print(database);
	session.setAttribute("database", database);
	try {
		Class.forName(driver);
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	}
	
	int flag = 0;
	Connection con = null;
	Statement statement = null;
	ResultSet resultSet = null;
	int rollno = Integer.parseInt(request.getParameter("uname"));
	
	int cat=0,total=0;
	String teacher_id = request.getParameter("name");
	String tname = request.getParameter("tname");
	String sname = request.getParameter("sname");
	String subject_id = request.getParameter("sub");
	Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection(connectionUrl+database, userid, password);
%>

<!DOCTYPE html>
<html class="loading" lang="en" data-textdirection="ltr">

<head>
    <title>Feedback</title>
    <link rel="apple-touch-icon" href="theme-assets/images/ico/apple-icon-120.png">
    <link rel="shortcut icon" type="image/x-icon" href="theme-assets/images/ico/favicon.ico">
    <link href="https://fonts.googleapis.com/css?family=Muli:300,300i,400,400i,600,600i,700,700i%7CComfortaa:300,400,700" rel="stylesheet">
    <link href="https://maxcdn.icons8.com/fonts/line-awesome/1.1/css/line-awesome.min.css" rel="stylesheet">
    <!-- BEGIN VENDOR CSS-->
    <link rel="stylesheet" type="text/css" href="theme-assets/css/vendors.css">
    <link rel="stylesheet" type="text/css" href="theme-assets/vendors/css/charts/chartist.css">
    <!-- END VENDOR CSS-->
    <!-- BEGIN CHAMELEON  CSS-->
    <link rel="stylesheet" type="text/css" href="theme-assets/css/app-lite.css">
    <!-- END CHAMELEON  CSS-->
    <!-- BEGIN Page Level CSS-->
    <link rel="stylesheet" type="text/css" href="theme-assets/css/core/menu/menu-types/vertical-menu.css">
    <link rel="stylesheet" type="text/css" href="theme-assets/css/core/colors/palette-gradient.css">
    <link rel="stylesheet" type="text/css" href="theme-assets/css/pages/dashboard-ecommerce.css">
    <!-- END Page Level CSS-->
    <!-- BEGIN Custom CSS-->
    <!-- END Custom CSS-->
</head>
<style>
	.question-card
	{
		position:relative;
		width:70%;
		height:20%;
		left:25%;
		margin-top:100px;		
	} 
</style>
<script src="/1st_increment_feedback/js/jquery.js"></script>
<script type="text/javascript">
	<%
		try{
			if(request.getParameter("flag")!=null)
			{
				flag = Integer.parseInt(request.getParameter("flag"));
				Statement st = con.createStatement();
				resultSet = st.executeQuery("select cat_id from teacher_class_subject where tid='"+teacher_id+"' and sid='"+subject_id+"' and cid_year in (select year from student where rollno='"+rollno+"') and cid_div in (select division from student where rollno='"+rollno+"')");
				resultSet.next();
				cat = resultSet.getInt("cat_id");
			}
            Statement st = con.createStatement();
            Statement st2 = con.createStatement();
            
			ResultSet rs = st.executeQuery("select count(*) as num_ques from question where qid in(select qid from temp_ques where temp_id in (select temp_id from teacher_subject_template where tid='"+teacher_id+"'and sid='"+subject_id+"'))");
            rs.next();
            total = rs.getInt("num_ques");
            ResultSet rs2 = st2.executeQuery("select * from question where qid in(select qid from temp_ques where temp_id in (select temp_id from teacher_subject_template where tid='"+teacher_id+"'and sid='"+subject_id+"'))");
            %>
            
            jQuery(document).ready(function(){
            	
            	if(<%=flag%>)
           		{
            		$('#questions').append("<center><h1><%=tname %>_<%=sname %></h1></center>");
           		}
            	 for(var no = 1; no <= <%=rs.getString("num_ques")%>;no++){ 
            	
              	  $('#questions').append('<div class="question-card"><div class="card"><div class="card-block"><div class="card-body"><div id="ques'+ no +'" class="ques" ></div></div></div></div></div>');

            	}
            	
            	if(<%=flag %>)
           		{
            		$('#questions').append('<div style="margin-bottom:100px; margin-left:30%;"><input class="btn" type="submit" value="submit"/></div>');
            		$('#questions').append('<div style="margin-bottom:100px; margin-left:30%;"><input type="hidden" name="total" value="<%=total%>"/></div>');
            		$('#questions').append('<div style="margin-bottom:100px; margin-left:30%;"><input type="hidden" name="cat" value="<%=cat%>"/></div>');
            		$('#questions').append('<div style="margin-bottom:100px; margin-left:30%;"><input type="hidden" name="subid" value="<%=subject_id%>"/></div>');
            		$('#questions').append('<div style="margin-bottom:100px; margin-left:30%;"><input type="hidden" name="tid" value="<%=teacher_id%>"/></div>');
            		$('#questions').append('<div style="margin-bottom:100px; margin-left:30%;"><input type="hidden" name="rid" value="<%=rollno%>"/></div>');
           		
           		}
            		
            	
            
            	var no = 1;
            	
            	
            	<%while(rs2.next()){%>
            	
            	if(no<=<%=rs.getString("num_ques")%>){
            		
            		$('#ques'+no).append('<p>'+no+'. <%=rs2.getString("question")%></p>');
            		if('<%=rs2.getString("option5")%>' == null)
            		{
            			$('#ques'+no).append('<input type="radio" value="50" name = "'+no+'"/><%=rs2.getString("option1")%>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp');
                		$('#ques'+no).append('<input type="radio" value="35" name = "'+no+'"/><%=rs2.getString("option2")%>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp');
                		$('#ques'+no).append('<input type="radio" value="25" name = "'+no+'"/><%=rs2.getString("option3")%>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp');
                		$('#ques'+no).append('<input type="radio" value="10" name = "'+no+'"/><%=rs2.getString("option4")%>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp');
            		}
            		else if('<%=rs2.getString("option4")%>' == null)
            		{
            			$('#ques'+no).append('<input type="radio" value="50" name = "'+no+'"/><%=rs2.getString("option1")%>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp');
                		$('#ques'+no).append('<input type="radio" value="30" name = "'+no+'"/><%=rs2.getString("option2")%>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp');
                		$('#ques'+no).append('<input type="radio" value="10" name = "'+no+'"/><%=rs2.getString("option3")%>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp');
            		}
            		else if('<%=rs2.getString("option3")%>' == null)
            		{
            			$('#ques'+no).append('<input type="radio" value="50" name = "'+no+'"/><%=rs2.getString("option1")%>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp');
                		$('#ques'+no).append('<input type="radio" value="10" name = "'+no+'"/><%=rs2.getString("option2")%>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp');
            		}
            		else
           			{
            			$('#ques'+no).append('<input type="radio" value="50" name = "'+no+'"/><%=rs2.getString("option1")%>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp');
                		$('#ques'+no).append('<input type="radio" value="40" name = "'+no+'"/><%=rs2.getString("option2")%>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp');
                		$('#ques'+no).append('<input type="radio" value="30" name = "'+no+'"/><%=rs2.getString("option3")%>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp');
                		$('#ques'+no).append('<input type="radio" value="20" name = "'+no+'"/><%=rs2.getString("option4")%>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp');
                		$('#ques'+no).append('<input type="radio" value="10" name = "'+no+'"/><%=rs2.getString("option5")%>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp');
           			}
            	}
            	no++;
            		
            	<%}%>
            	
            	var $currentElement = $('.question-card').first();

        		//alert($currentElement)

    			$('div.question-card input ').on('click',function () {

    				//alert('Div clicked')

    			    var $nextElement = $currentElement.next('.question-card');
    			     //Check if next element actually exists
    			    	if($nextElement.length) {
    			        // If yes, update:
    			        // 1. $currentElement
    			        // 2. Scroll position
    			        $currentElement = $nextElement;
    			        //alert('lalalal')
    			        $('html, body').animate({
    			            scrollTop: $nextElement.offset().top - 150 
    			        }, 'slow');
    			    }
    			    else{
    			    	$currentElement = $('.question-card').first();
    			    	//alert('ksfhdsjk')
    			    }
    			      
            	});
            });
            
		<%
		}
		catch(Exception e){
			e.printStackTrace();
		}
	%>
</script>

<body class="vertical-layout vertical-menu 2-columns   menu-expanded fixed-navbar" data-open="click" data-menu="vertical-menu" data-color="bg-chartbg" data-col="2-columns">

    <!-- ////////////////////////////////////////////////////////////////////////////-->


     <div class="main-menu menu-fixed menu-light menu-accordion  menu-shadow " style="width:20%;" data-scroll-to-active="true" data-img="theme-assets/images/backgrounds/02.jpg">
        <div class="navbar-header">
            <ul class="nav navbar-nav flex-row">
                <li class="nav-item mr-auto">
                    <a class="navbar-brand" href="index.html"><img class="brand-logo" alt="Chameleon admin logo" src="theme-assets/images/logo/pict.jpg" />
                    	Feedback                        
                    </a>
                </li>
                <li class="nav-item d-md-none"><a class="nav-link close-navbar"><i class="ft-x"></i></a></li>
            </ul>
        </div>
        <div class="main-menu-content">
            <ul class="navigation navigation-main" id="main-menu-navigation" data-menu="menu-navigation">
            	<%
					try{
				    		statement=con.createStatement();
				    		String sql = "select domain_name from domain";
							
				    		resultSet = statement.executeQuery(sql);
				    		while(resultSet.next()){
				    			String t_name = resultSet.getString("domain_name");
				%>
						   		<li class="nav-item"><a href="#"><i class="ft-home"></i><span class="menu-title" data-i18n=""><%=t_name %></span></a>
						   			<ul>
						   				<%
						   					ResultSet rs = null;
						   					ResultSet rs1 = null;
						   					ResultSet rs2 = null;
						   					Statement statement1=con.createStatement();
						   					Statement statement2=con.createStatement();
						   					System.out.println(t_name);
						   					if(t_name.equals("LTL"))
						   					{
						   						System.out.print("1111HEY");
						   						rs = statement1.executeQuery("select * from student_cat join teachers on tid=id join subject on sid=subject_id where rollno='"+rollno+"' and domain_name='"+t_name+"'");
						   						while(rs.next()){
									    			String name = rs.getString("name");
									    			String sub = rs.getString("subject_name");
									    			String tid = rs.getString("tid");
									    			String subid = rs.getString("subject_id");
									    			if(rs.getInt("fc")==1)
									    			{
												%>
												<li class="nav-item"><a style="color: currentColor; cursor: not-allowed; opacity: 0.5;text-decoration: none;"><%=name %>_<%=sub %></a></li>
													<%
									    			}
													else
													{
													%><li class="nav-item"><a href="index.jsp?name=<%=tid%>&sub=<%=subid%>&flag=1&tname=<%=name %>&sname=<%=sub %>&uname=<%=rollno %>" ><%=name %>_<%=sub %></a></li>
												<%}
						   						}
						   					}
						   					else
						   					{
						   						System.out.print("HEYoooo");
						   						rs = statement1.executeQuery("select * from teacher_class_subject join teachers on tid=id join subject on sid=subject_id where cid_year in (select year from student where rollno='"+rollno+"') and cid_div in (select division from student where rollno='"+rollno+"') and domain_name='"+t_name+"'");
								   				while(rs.next()){
									    			String name = rs.getString("name");
									    			String sub = rs.getString("subject_name");
									    			String tid = rs.getString("tid");
									    			String subid = rs.getString("sid");
									    			System.out.println(subid+"  "+tid);
									    			rs2 = statement2.executeQuery("select * from studcheck where sid="+subid+" and rollno="+rollno+";");
													rs2.next();								    			
									    			if(rs2.getInt("fc")==1)
									    			{
									    				%>
														<li class="nav-item"><a style="color: currentColor; cursor: not-allowed; opacity: 0.5;text-decoration: none;"  ><%=name %>_<%=sub %></a></li>
														<%
									    			}
									    			else
									    			{
									    				%>
														
														<li class="nav-item"><a href="index.jsp?name=<%=tid%>&sub=<%=subid%>&flag=1&tname=<%=name %>&sname=<%=sub %>&uname=<%=rollno %>" ><%=name %>_<%=sub %></a></li>
														<%
						    				
									    			}
									    		} 
						   					}
												%>
															
						   			</ul>
						   		</li>		    		
				<%
				    		}
			    			con.close(); 
				    	}
			    	 	catch (Exception e) {
			    			e.printStackTrace();
			    		}
				%>
  				<li class="nav-item"><a href="Login1.jsp"><i class="ft-bold"></i><span class="menu-title" data-i18n="">Logout</span></a></li>
            </ul>
	       
        <div class="navigation-background"></div>
    </div>
</div>

    <!-- /////////////////////////////////////////////////////////////////////////////-->
   	<form action ="processanswer.jsp" accept-charset=utf-8  id ="questions">
   	</form>
    <!-- BEGIN VENDOR JS-->
    <script src="theme-assets/vendors/js/vendors.min.js" type="text/javascript"></script>
    <!-- BEGIN VENDOR JS-->
    <!-- BEGIN PAGE VENDOR JS-->
    <script src="theme-assets/vendors/js/charts/chartist.min.js" type="text/javascript"></script>
    <!-- END PAGE VENDOR JS-->
    <!-- BEGIN CHAMELEON  JS-->
    <script src="theme-assets/js/core/app-menu-lite.js" type="text/javascript"></script>
    <script src="theme-assets/js/core/app-lite.js" type="text/javascript"></script>
    <!-- END CHAMELEON  JS-->
    <!-- BEGIN PAGE LEVEL JS-->
    <script src="theme-assets/js/scripts/pages/dashboard-lite.js" type="text/javascript"></script>
    <!-- END PAGE LEVEL JS-->
</body>

</html>
