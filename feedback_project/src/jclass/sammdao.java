package jclass;
import java.sql.*;



public class sammdao 
	{
		
		public void dell(String[] arr,String db_name)
		{
			
			
			try
			{
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db_name,"Deva","dev123456");
				Statement st = con.createStatement();
				for(int i=0;i<arr.length;i++)
				st.executeUpdate("delete from teachers where id="+arr[i]+";");
			}
			catch(Exception e)
			{
				System.out.println(e);
			}
			
		}
		public void classdel(String[] arr, String db_name)
		{
			
			
			try
			{
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db_name,"Deva","dev123456");
				Statement st = con.createStatement();
				for(int i=0;i<arr.length;i++)
				{
					String[] p=arr[i].split("#",-2);
				st.executeUpdate("delete from class where division="+p[1]+" and year='"+p[0]+"';");
				}
			}
			catch(Exception e)
			{
				System.out.println(e);
			}
			
		}
		public void domaindel(String[] arr, String db_name)
		{
			
			
			try
			{
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db_name,"Deva","dev123456");
				Statement st = con.createStatement();
				for(int i=0;i<arr.length;i++)
				st.executeUpdate("delete from domain where domain_name='"+arr[i]+"';");
			}
			catch(Exception e)
			{
				System.out.println(e);
			}
			
		}
		public void questiondel(String[] arr, String db_name)
		{
			
			
			try
			{
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db_name,"Deva","dev123456");
				Statement st = con.createStatement();
				for(int i=0;i<arr.length;i++)
				st.executeUpdate("delete from question where qid="+arr[i]+";");
			}
			catch(Exception e)
			{
				System.out.println(e);
			}
			
		}
		public void subjectdel(String[] arr, String db_name)
		{
			
			
			try
			{
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db_name,"Deva","dev123456");
				Statement st = con.createStatement();
				for(int i=0;i<arr.length;i++)
				{
					
					
				st.executeUpdate("delete from subject where subject_id="+arr[i]+";");
				}
			}
			catch(Exception e)
			{
				System.out.println(e);
			}
			
		}
		public void templatedel(String[] arr, String db_name)
		{
			
			
			try
			{
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db_name,"Deva","dev123456");
				Statement st = con.createStatement();
				for(int i=0;i<arr.length;i++)
	
				st.executeUpdate("delete from template where temp_name='"+arr[i]+"';");
			}
			catch(Exception e)
			{
				System.out.println(e);
			}
			
		}
		public void teachtempdel(String[] arr, String db_name)
		{
			
			
			try
			{
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db_name,"Deva","dev123456");
				Statement st = con.createStatement();
				for(int i=0;i<arr.length;i++)
				{
					String[] p=arr[i].split("#",-3);
				st.executeUpdate("delete from teacher_subject_template where tid="+p[0]+" and sid="+p[1]+" and temp_id='"+p[2]+"'");
			}
			}
			catch(Exception e)
			{
				System.out.println(e);
			}
			
		}
		
		public void tcsdel(String[] arr, String db_name)
		{
			
			
			try
			{
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db_name,"Deva","dev123456");
				Statement st = con.createStatement();
				for(int i=0;i<arr.length;i++)
				{
					String[] p=arr[i].split("#",-3);
					
		     		st.executeUpdate("delete from teacher_class_subject where tid=(select tid from teachers where name='"+p[0]+"') and sid=(select subject_id from subject where subject_name='"+p[1]+"') and cid_year='"+p[2]+"' and cid_div="+p[3]+"");
			    }
			}
			catch(Exception e)
			{
				System.out.println(e);
			}
			
		}
		
		
		
		
	}