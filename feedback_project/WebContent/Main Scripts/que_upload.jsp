<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>

<%@page import="org.apache.poi.ss.usermodel.*"%>
<%@page import="org.apache.poi.xssf.usermodel.*"%>
<%@page import="org.apache.poi.hssf.usermodel.*"%>
<%@ page import="org.apache.poi.poifs.filesystem.POIFSFileSystem"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		//String path = "data/";
		String path = "/tmp/data";
		File path_file = new File(path);
		
		if(!path_file.exists()){
			if(path_file.mkdirs())
				System.out.println("File created");
		}
	
		MultipartRequest mr = new MultipartRequest(request, path);
		//storing the path of the uploaded file
		System.out.println("In upload");
		String filepath = mr.getFile("upload").toString();
		File f = new File(filepath);
		String temp_name = (String)session.getAttribute("tempID");
		System.out.println(temp_name);
		try {
			int i = 0;
			int flag = 0;
			String str = new String();
			String str1 = new String();
			int n = 0, cnt;
			int updateQuery;
			PreparedStatement pstatement = null;
			PreparedStatement pstatement1 = null;
			
			Class.forName("com.mysql.jdbc.Driver");
			String database = (String)session.getAttribute("curdb");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+database, "Deva", "dev123456");
			Statement st = con.createStatement();
			Statement st1 = con.createStatement();
			XSSFRow row;
			FileInputStream fis = new FileInputStream(f);
			XSSFWorkbook workbook = new XSSFWorkbook(fis);
			XSSFSheet spreadsheet = workbook.getSheetAt(0);
			Iterator<Row> rowIterator = spreadsheet.iterator();
			String[] names = new String[6];
			int j = 0;
			
			while (rowIterator.hasNext()) {
				if(flag == 0){
					row = (XSSFRow) rowIterator.next(); //for skipping Header Row	
				}
				flag = 1;
				row = (XSSFRow) rowIterator.next();
				
				Iterator<Cell> cellIterator = row.cellIterator();
				j =0 ;
				while (cellIterator.hasNext()) {
					Cell cell = cellIterator.next();
					names[j] = cell.getStringCellValue();
					j++;
					
				}
				int maxid;
				String sql = "select max(qid) as mqid from question";
				ResultSet resultSet1 = st1.executeQuery(sql);
				if(resultSet1.next()){
					String temp = resultSet1.getString("mqid");
					if(temp != null)
						maxid = Integer.parseInt(temp);
					else
						maxid = 0;
				}
				else
					maxid = 0;
				
			
					//System.out.println(names[j]);
					
						
					String queryString = "INSERT INTO question(qid,question,option1,option2,option3,option4,option5) VALUES (?,?,?,?,?,?,?)";
					pstatement = con.prepareStatement(queryString);
					
					pstatement.setInt(1, (maxid+1));
					pstatement.setString(2, names[0]);
					pstatement.setString(3, names[1]);
					pstatement.setString(4, names[2]);
					pstatement.setString(5, names[3]);
					pstatement.setString(6, names[4]);
					pstatement.setString(7, names[5]);
					
					updateQuery = pstatement.executeUpdate();

					Statement stmt = con.createStatement();
					int m = stmt.executeUpdate("insert into temp_ques values('"+temp_name+"',"+(maxid+1)+")");
				}
			

			if (f.delete()) {
				System.out.println("Questions Added");
				session.setAttribute("tempID",temp_name);
				response.sendRedirect("addquestion.jsp");
			}

			session.setAttribute("tempID",temp_name);
			//response.sendRedirect("addquestion.jsp");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			response.sendRedirect("addquestion.jsp");
		}
	%>



</body>
</html>