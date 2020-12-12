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
		//System.out.println("Request In Staff_Upload");
		//String path = "data/";
		String path = "/tmp/data";
		File path_file = new File(path);
		
		if(!path_file.exists()){
			if(path_file.mkdirs())
				System.out.println("File created");
		}
		
		MultipartRequest mr = new MultipartRequest(request, path);
		//storing the path of the uploaded file

		String filepath = mr.getFile("upload").toString();
		File f = new File(filepath);
		StringBuilder errorString = new StringBuilder();
		
		try {
			int i = 0;
			int flag = 0;
			String str = new String();
			String str1 = new String();
			int n = 0, cnt;
			int updateQuery;
			PreparedStatement pstatement = null;
			Class.forName("com.mysql.jdbc.Driver");
			String database = (String)session.getAttribute("curdb");
			//System.out.println("in staff upload : "+database);
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+database, "Deva", "dev123456");
			Statement st = con.createStatement();
			Statement st1 = con.createStatement();
			XSSFRow row;
			FileInputStream fis = new FileInputStream(f);
			XSSFWorkbook workbook = new XSSFWorkbook(fis);
			XSSFSheet spreadsheet = workbook.getSheetAt(0);
			Iterator<Row> rowIterator = spreadsheet.iterator();
			String[] names = new String[3];
			int j = 0;
			while (rowIterator.hasNext()) {
				if(flag == 0){
					row = (XSSFRow) rowIterator.next();
				}
				flag = 1;
				row = (XSSFRow) rowIterator.next();
				Iterator<Cell> cellIterator = row.cellIterator();
				j =0 ;
				while (cellIterator.hasNext()) {
					Cell cell = cellIterator.next();
					str = cell.getStringCellValue();
					names[j] = str;
					j++;
						
				}
				
			
					
					String queryString = "INSERT INTO teachers(name,dept) VALUES (?,?)";
					
					pstatement = con.prepareStatement(queryString);
					
					pstatement.setString(1, names[0]);
					pstatement.setString(2, names[1]);
					
					str = names[0];
					String check = "select * from teachers where name = '" + str + "' ";
					ResultSet rs = st1.executeQuery(check);
					rs.next();
					rs.last();
					
					int count1 = rs.getRow();
					rs.first();
					if (count1 > 0) {
						errorString.append(str+" Is Already Added\n");
						//System.out.println(str+" Is Already Added");
						//response.sendRedirect("Teachers.jsp");
					} else {
						updateQuery = pstatement.executeUpdate();
						
					}
					
					
			}
			

			if (f.delete()) {
				flag = 0;
				errorString.append("Staff Added\n");
				System.out.println(errorString);
				//session.setAttribute("error", errorString);
				response.sendRedirect("Teachers.jsp");
			}
			//session.setAttribute("error", errorString);
			System.out.println(errorString);
			//response.sendRedirect("Teachers.jsp");
			
			
		} catch (Exception e) {
			errorString.append(e.getMessage()+"\n");
			System.out.println(errorString);
			//session.setAttribute("error", errorString);
			response.sendRedirect("Teachers.jsp");
		}
	%>



</body>
</html>