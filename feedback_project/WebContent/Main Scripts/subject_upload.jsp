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
		System.out.print("In sub upload \n");
		//String path = "/home/aniket/PICT-Feedback/1st_increment_feedback/WebContent/Main Scripts/data/";
		String path = "/tmp/data";
		File path_file = new File(path);
		
		if(!path_file.exists()){
			if(path_file.mkdirs())
				System.out.println("File created");
		}
		
		MultipartRequest mr = new MultipartRequest(request,path);
		//storing the path of the uploaded file

		String filepath = mr.getFile("upload").toString();
		File f = new File(filepath);

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
			System.out.println("In subject_upload");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+database, "Deva", "dev123456");
			Statement st = con.createStatement();
			Statement st1 = con.createStatement();
			XSSFRow row;
			FileInputStream fis = new FileInputStream(f);
			XSSFWorkbook workbook = new XSSFWorkbook(fis);
			XSSFSheet spreadsheet = workbook.getSheetAt(0);
			Iterator<Row> rowIterator = spreadsheet.iterator();
			String[] names = new String[4];
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
					switch (cell.getCellType()) {
					case NUMERIC:
						n = (int) cell.getNumericCellValue();
						System.out.println(n);
						break;

					case STRING:
						names[j] = cell.getStringCellValue();
						System.out.println(names[j]);
						j++;
						break;
					}

					}
					//System.out.println("\nReached Mark 0");

					//System.out.println(names[j]);
					
					//System.out.println("\nReached Mark 2");
						
					String queryString = "INSERT INTO subject(subject_id,subject_name,dept_id,yr,domain_name) VALUES (?,?,?,?,?)";
					pstatement = con.prepareStatement(queryString);
					
					pstatement.setInt(1, n);
					
					pstatement.setString(2, names[0]);
					
					pstatement.setString(3, names[2]);
					
					pstatement.setString(4, names[3]);
					
					
					pstatement.setString(5, names[1]);
					
					
					updateQuery = pstatement.executeUpdate();
					
					System.out.println("\nReached Mark 7");
					
			}
			

			if (f.delete()) {
				response.sendRedirect("subject.jsp");
			}
			//response.sendRedirect("subject.jsp");
			
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			response.sendRedirect("subject.jsp");
		}
	%>
</body>
</html>