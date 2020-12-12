<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
	// database to be created/dropped
	String year =(String) request.getParameter("select_year");
	System.out.println("year is "+year);
	
	String database = null;
	String username = "Deva";
	String password = "dev123456";
	String url = "jdbc:mysql://localhost:3306/";
	Connection connection = null;
	Statement statement = null, statement2 = null, statement3 = null;
	ResultSet rset, rnew, curdb = null;
	boolean databaseListChanged = false;
	boolean usedbflag = false;
	int result = -1, result2 = -1, result3 = -1;
//	String schema_path = "/home/aniket/Documents/PICT-Feedback-System/NewUpdatedJan24.sql";
	
	//session.setAttribute("select_db_year",year);
	
	String query1 = "DROP TABLE IF EXISTS accounts;";
	
	String query2 = "CREATE TABLE accounts ("+
			  "name varchar(255) NOT NULL,"+
			  "pass varchar(255) NOT NULL"+
			");";
			
	String query3 = "LOCK TABLES accounts WRITE;";
	
	String query4 = "INSERT INTO accounts VALUES ('admin','admin');";
	
	String query5 = "UNLOCK TABLES;";
	
	String query6 = "DROP TABLE IF EXISTS class;";
	
	String query7 = "CREATE TABLE class ("+
			  "year char(2) NOT NULL,"+
			  "division int(11) NOT NULL,"+
			  "dept varchar(20) DEFAULT NULL,"+
			  "ran1 int(11) DEFAULT NULL,"+
			  "ran2 int(11) DEFAULT NULL,"+
			  "PRIMARY KEY (year,division),"+
			  "KEY fk3 (dept),"+
			  "CONSTRAINT fk3 FOREIGN KEY (dept) REFERENCES dept (dept_name) ON DELETE CASCADE ON UPDATE CASCADE"+
			");";
	
	String query8 = "LOCK TABLES class WRITE;";
	
//	String query9 = "INSERT INTO class VALUES ('SE',3,'IT',10,20),('TE',9,'IT',33101,33174),('TE',10,'IT',33201,33270),('TE',11,'IT',33301,33374);";
	
	String query10 = "UNLOCK TABLES;";
	
	String query11 = "DROP TABLE IF EXISTS dept;";
	
	String query12 = "CREATE TABLE dept ("+
			  "dept_name varchar(20) NOT NULL,"+
			  "PRIMARY KEY (dept_name)"+
			");";
		
	String query13 = "LOCK TABLES dept WRITE;";
	
	String query14 = "INSERT INTO dept VALUES ('AS'),('CS'),('EnTC'),('IT');";
	
	String query15 = "UNLOCK TABLES;";
	
	String query16 = "DROP TABLE IF EXISTS domain;";
	
	String query17 = "CREATE TABLE domain ("+
			  "domain_name varchar(20) NOT NULL,"+
			  "PRIMARY KEY (domain_name)" +
			");";
	
	String query18 = "LOCK TABLES domain WRITE;";
	
	//String query19 = "INSERT INTO domain VALUES ('CTL'),('LTL'),('SPORTS');";
	
	String query20 = "UNLOCK TABLES;";
	
	String query21 = "DROP TABLE IF EXISTS feedback;";
	
	String query22 = "CREATE TABLE feedback ("+
			  "cat_id int(11) DEFAULT NULL,"+
			  "qid int(11) DEFAULT NULL,"+
			  "score int(11) DEFAULT NULL,"+
			  "KEY fk1 (cat_id),"+
			  "CONSTRAINT fk1 FOREIGN KEY (cat_id) REFERENCES teacher_class_subject (cat_id) ON DELETE CASCADE ON UPDATE CASCADE"+
			");";
	
	String query23 = "LOCK TABLES feedback WRITE;";
	
	//String query24 = "INSERT INTO feedback VALUES (15,1,0),(12,1,0),(15,1,0),(15,2,0),(12,2,0),(15,2,0),(13,3,0),(16,3,0),(13,4,0),(16,4,0);";
	
	String query25 = "UNLOCK TABLES;";
	
	String query26 = "DROP TABLE IF EXISTS question;";
	
	String query27 = "CREATE TABLE question ("+
			  "question varchar(120) DEFAULT NULL,"+
			  "option1 varchar(50) DEFAULT NULL,"+
			  "option2 varchar(50) DEFAULT NULL,"+
			  "option3 varchar(50) DEFAULT NULL,"+
			  "option4 varchar(50) DEFAULT NULL,"+
			  "qid int(11) NOT NULL,"+
			  "option5 varchar(50) DEFAULT NULL,"+
			  "PRIMARY KEY (qid)"+
			");";
			
	String query28 = "LOCK TABLES question WRITE;";
	
	//String query29 = "INSERT INTO question VALUES ('Can you hear the teacher','Good','Fair','Bad','Worst',1,'cant say'),('Can you understand teacher','Good','Fair','Bad','Worst',2,'cant say'),('Can you understand teacher','Good','Fair','Bad','Worst',3,'cant say'),('Can you perform well','Good','Fair','Bad','Worst',4,'cant say');";
	
	String query30 = "UNLOCK TABLES;";
	
	String query31 = "DROP TABLE IF EXISTS studcheck;";
	
	String query32 = "CREATE TABLE studcheck ("+
			  "rollno int(11) NOT NULL,"+
			  "year varchar(3) DEFAULT NULL,"+
			  "division int(11) DEFAULT NULL,"+
			  "sid int(11) NOT NULL,"+
			  "fc int(11) DEFAULT '0'"+
			");";
	
	String query33 = "LOCK TABLES studcheck WRITE;";
	
	//String query34 = "INSERT INTO studcheck VALUES (10,'SE',3,420,0),(11,'SE',3,420,0),(12,'SE',3,420,0),(13,'SE',3,420,0),(14,'SE',3,420,0),(15,'SE',3,420,0),(16,'SE',3,420,0),(17,'SE',3,420,0),(18,'SE',3,420,0),(19,'SE',3,420,0),(20,'SE',3,420,0),(10,'SE',3,111,0),(11,'SE',3,111,0),(12,'SE',3,111,0),(13,'SE',3,111,0),(14,'SE',3,111,0),(15,'SE',3,111,0),(16,'SE',3,111,0),(17,'SE',3,111,0),(18,'SE',3,111,0),(19,'SE',3,111,0),(20,'SE',3,111,0),(33301,'TE',11,2,0),(33302,'TE',11,2,0),(33303,'TE',11,2,0),(33304,'TE',11,2,0),(33305,'TE',11,2,0),(33306,'TE',11,2,0),(33307,'TE',11,2,0),(33308,'TE',11,2,0),(33309,'TE',11,2,0),(33310,'TE',11,2,0),(33311,'TE',11,2,0),(33312,'TE',11,2,0),(33313,'TE',11,2,0),(33314,'TE',11,2,0),(33315,'TE',11,2,0),(33316,'TE',11,2,0),(33317,'TE',11,2,0),(33318,'TE',11,2,0),(33319,'TE',11,2,0),(33320,'TE',11,2,0),(33321,'TE',11,2,0),(33322,'TE',11,2,0),(33323,'TE',11,2,0),(33324,'TE',11,2,0),(33325,'TE',11,2,0),(33326,'TE',11,2,0),(33327,'TE',11,2,0),(33328,'TE',11,2,0),(33329,'TE',11,2,0),(33330,'TE',11,2,0),(33331,'TE',11,2,0),(33332,'TE',11,2,0),(33333,'TE',11,2,0),(33334,'TE',11,2,0),(33335,'TE',11,2,0),(33336,'TE',11,2,0),(33337,'TE',11,2,0),(33338,'TE',11,2,0),(33339,'TE',11,2,0),(33340,'TE',11,2,0),(33341,'TE',11,2,0),(33342,'TE',11,2,0),(33343,'TE',11,2,0),(33344,'TE',11,2,0),(33345,'TE',11,2,0),(33346,'TE',11,2,0),(33347,'TE',11,2,0),(33348,'TE',11,2,0),(33349,'TE',11,2,0),(33350,'TE',11,2,0),(33351,'TE',11,2,0),(33352,'TE',11,2,0),(33353,'TE',11,2,0),(33354,'TE',11,2,0),(33355,'TE',11,2,0),(33356,'TE',11,2,0),(33357,'TE',11,2,0),(33358,'TE',11,2,0),(33359,'TE',11,2,0),(33360,'TE',11,2,0),(33361,'TE',11,2,0),(33362,'TE',11,2,0),(33363,'TE',11,2,0),(33364,'TE',11,2,0),(33365,'TE',11,2,0),(33366,'TE',11,2,0),(33367,'TE',11,2,0),(33368,'TE',11,2,0),(33369,'TE',11,2,0),(33370,'TE',11,2,0),(33371,'TE',11,2,0),(33372,'TE',11,2,0),(33373,'TE',11,2,0),(33374,'TE',11,2,0),(33301,'TE',11,1,0),(33302,'TE',11,1,0),(33303,'TE',11,1,0),(33304,'TE',11,1,0),(33305,'TE',11,1,0),(33306,'TE',11,1,0),(33307,'TE',11,1,0),(33308,'TE',11,1,0),(33309,'TE',11,1,0),(33310,'TE',11,1,0),(33311,'TE',11,1,0),(33312,'TE',11,1,0),(33313,'TE',11,1,0),(33314,'TE',11,1,0),(33315,'TE',11,1,0),(33316,'TE',11,1,0),(33317,'TE',11,1,0),(33318,'TE',11,1,0),(33319,'TE',11,1,0),(33320,'TE',11,1,0),(33321,'TE',11,1,0),(33322,'TE',11,1,0),(33323,'TE',11,1,0),(33324,'TE',11,1,0),(33325,'TE',11,1,0),(33326,'TE',11,1,0),(33327,'TE',11,1,0),(33328,'TE',11,1,0),(33329,'TE',11,1,0),(33330,'TE',11,1,0),(33331,'TE',11,1,0),(33332,'TE',11,1,0),(33333,'TE',11,1,0),(33334,'TE',11,1,0),(33335,'TE',11,1,0),(33336,'TE',11,1,0),(33337,'TE',11,1,0),(33338,'TE',11,1,0),(33339,'TE',11,1,0),(33340,'TE',11,1,0),(33341,'TE',11,1,0),(33342,'TE',11,1,0),(33343,'TE',11,1,0),(33344,'TE',11,1,0),(33345,'TE',11,1,0),(33346,'TE',11,1,0),(33347,'TE',11,1,0),(33348,'TE',11,1,0),(33349,'TE',11,1,0),(33350,'TE',11,1,0),(33351,'TE',11,1,0),(33352,'TE',11,1,0),(33353,'TE',11,1,0),(33354,'TE',11,1,0),(33355,'TE',11,1,0),(33356,'TE',11,1,0),(33357,'TE',11,1,0),(33358,'TE',11,1,0),(33359,'TE',11,1,0),(33360,'TE',11,1,0),(33361,'TE',11,1,0),(33362,'TE',11,1,0),(33363,'TE',11,1,0),(33364,'TE',11,1,0),(33365,'TE',11,1,0),(33366,'TE',11,1,0),(33367,'TE',11,1,0),(33368,'TE',11,1,0),(33369,'TE',11,1,0),(33370,'TE',11,1,0),(33371,'TE',11,1,0),(33372,'TE',11,1,0),(33373,'TE',11,1,0),(33374,'TE',11,1,0),(33301,'TE',11,3,0),(33302,'TE',11,3,0),(33303,'TE',11,3,0),(33304,'TE',11,3,0),(33305,'TE',11,3,0),(33306,'TE',11,3,0),(33307,'TE',11,3,0),(33308,'TE',11,3,0),(33309,'TE',11,3,0),(33310,'TE',11,3,0),(33311,'TE',11,3,0),(33312,'TE',11,3,0),(33313,'TE',11,3,0),(33314,'TE',11,3,0),(33315,'TE',11,3,0),(33316,'TE',11,3,0),(33317,'TE',11,3,0),(33318,'TE',11,3,0),(33319,'TE',11,3,0),(33320,'TE',11,3,0),(33321,'TE',11,3,0),(33322,'TE',11,3,0),(33323,'TE',11,3,0),(33324,'TE',11,3,0),(33325,'TE',11,3,0),(33326,'TE',11,3,0),(33327,'TE',11,3,0),(33328,'TE',11,3,0),(33329,'TE',11,3,0),(33330,'TE',11,3,0),(33331,'TE',11,3,0),(33332,'TE',11,3,0),(33333,'TE',11,3,0),(33334,'TE',11,3,0),(33335,'TE',11,3,0),(33336,'TE',11,3,0),(33337,'TE',11,3,0),(33338,'TE',11,3,0),(33339,'TE',11,3,0),(33340,'TE',11,3,0),(33341,'TE',11,3,0),(33342,'TE',11,3,0),(33343,'TE',11,3,0),(33344,'TE',11,3,0),(33345,'TE',11,3,0),(33346,'TE',11,3,0),(33347,'TE',11,3,0),(33348,'TE',11,3,0),(33349,'TE',11,3,0),(33350,'TE',11,3,0),(33351,'TE',11,3,0),(33352,'TE',11,3,0),(33353,'TE',11,3,0),(33354,'TE',11,3,0),(33355,'TE',11,3,0),(33356,'TE',11,3,0),(33357,'TE',11,3,0),(33358,'TE',11,3,0),(33359,'TE',11,3,0),(33360,'TE',11,3,0),(33361,'TE',11,3,0),(33362,'TE',11,3,0),(33363,'TE',11,3,0),(33364,'TE',11,3,0),(33365,'TE',11,3,0),(33366,'TE',11,3,0),(33367,'TE',11,3,0),(33368,'TE',11,3,0),(33369,'TE',11,3,0),(33370,'TE',11,3,0),(33371,'TE',11,3,0),(33372,'TE',11,3,0),(33373,'TE',11,3,0),(33374,'TE',11,3,0);";
	
	String query35 = "UNLOCK TABLES;";
	
	String query36 = "DROP TABLE IF EXISTS student;";
	
	String query37 = "CREATE TABLE student ("+
			  "rollno int(11) NOT NULL,"+
			  "year char(2) DEFAULT NULL,"+
			  "division int(11) DEFAULT NULL,"+
			  "pass varchar(45) DEFAULT NULL,"+
			  "feedcheck int(11) NOT NULL DEFAULT '0',"+
			  "PRIMARY KEY (rollno),"+
			  "KEY year (year,division),"+
			  "CONSTRAINT student_ibfk_1 FOREIGN KEY (year, division) REFERENCES class (year, division) ON DELETE CASCADE ON UPDATE CASCADE"+
			");";
			
	String query38 = "LOCK TABLES student WRITE;";
	
	//String query39 = "INSERT INTO student VALUES (10,'SE',3,NULL,0),(11,'SE',3,NULL,0),(12,'SE',3,NULL,0),(13,'SE',3,NULL,0),(14,'SE',3,NULL,0),(15,'SE',3,NULL,0),(16,'SE',3,NULL,0),(17,'SE',3,NULL,0),(18,'SE',3,NULL,0),(19,'SE',3,NULL,0),(20,'SE',3,NULL,0),(33101,'TE',9,'[C@5f7109af',0),(33102,'TE',9,'[C@41302ff3',0),(33103,'TE',9,'[C@26ff78e0',0),(33104,'TE',9,'[C@59dbe7ca',0),(33105,'TE',9,'[C@eb0b12f',0),(33106,'TE',9,'[C@4ebf58bd',0),(33107,'TE',9,'[C@13da01f2',0),(33108,'TE',9,'[C@153941f4',0),(33109,'TE',9,'[C@1e0ba3b5',0),(33110,'TE',9,'[C@2a457a79',0),(33111,'TE',9,'[C@69d32b52',0),(33112,'TE',9,'[C@36bae17d',0),(33113,'TE',9,'[C@756fea14',0),(33114,'TE',9,'[C@7478c072',0),(33115,'TE',9,'[C@481ec14',0),(33116,'TE',9,'[C@655144f0',0),(33117,'TE',9,'[C@6f642d04',0),(33118,'TE',9,'[C@5d2d1bca',0),(33119,'TE',9,'[C@5647ad37',0),(33120,'TE',9,'[C@395e15cb',0),(33121,'TE',9,'[C@779c13e9',0),(33122,'TE',9,'[C@42dab59b',0),(33123,'TE',9,'[C@299f86e2',0),(33124,'TE',9,'[C@60a63e57',0),(33125,'TE',9,'[C@77b27af1',0),(33126,'TE',9,'[C@60537ff1',0),(33127,'TE',9,'[C@352e4d8f',0),(33128,'TE',9,'[C@64ab89fb',0),(33129,'TE',9,'[C@aa126d',0),(33130,'TE',9,'[C@7bfd497e',0),(33131,'TE',9,'[C@3c7821bb',0),(33132,'TE',9,'[C@4a4939e',0),(33133,'TE',9,'[C@54cdd01d',0),(33134,'TE',9,'[C@456ad543',0),(33135,'TE',9,'[C@38e251ac',0),(33136,'TE',9,'[C@18fa1d4d',0),(33137,'TE',9,'[C@228d7b77',0),(33138,'TE',9,'[C@315e62a8',0),(33139,'TE',9,'[C@1b9b2a1e',0),(33140,'TE',9,'[C@53c34c55',0),(33141,'TE',9,'[C@1a5cd399',0),(33142,'TE',9,'[C@5855a958',0),(33143,'TE',9,'[C@1a5ca396',0),(33144,'TE',9,'[C@53b4e56c',0),(33145,'TE',9,'[C@2f083498',0),(33146,'TE',9,'[C@5a624748',0),(33147,'TE',9,'[C@25dd1f81',0),(33148,'TE',9,'[C@51b611d3',0),(33149,'TE',9,'[C@3f744389',0),(33150,'TE',9,'[C@77641b28',0),(33151,'TE',9,'[C@3a082352',0),(33152,'TE',9,'[C@5bd19549',0),(33153,'TE',9,'[C@4624edb1',0),(33154,'TE',9,'[C@11ce0306',0),(33155,'TE',9,'[C@6aa7a0de',0),(33156,'TE',9,'[C@3d8b0b1e',0),(33157,'TE',9,'[C@5ca3207b',0),(33158,'TE',9,'[C@3d14ceda',0),(33159,'TE',9,'[C@6ae238f6',0),(33160,'TE',9,'[C@f541d4f',0),(33161,'TE',9,'[C@4ab14426',0),(33162,'TE',9,'[C@514831b4',0),(33163,'TE',9,'[C@2a1686e3',0),(33164,'TE',9,'[C@507488b',0),(33165,'TE',9,'[C@4557ac79',0),(33166,'TE',9,'[C@5502e0f6',0),(33167,'TE',9,'[C@4b3d552b',0),(33168,'TE',9,'[C@74410fd7',0),(33169,'TE',9,'[C@c0d5142',0),(33170,'TE',9,'[C@4e4a0565',0),(33171,'TE',9,'[C@6f7f958a',0),(33172,'TE',9,'[C@133c0005',0),(33173,'TE',9,'[C@75ddd461',0),(33174,'TE',9,'[C@6ba28692',0),(33201,'TE',10,'[C@78628da9',0),(33202,'TE',10,'[C@b2d8688',0),(33203,'TE',10,'[C@10483550',0),(33204,'TE',10,'[C@6f21a7dd',0),(33205,'TE',10,'[C@3c26055',0),(33206,'TE',10,'[C@643caf63',0),(33207,'TE',10,'[C@350ff401',0),(33208,'TE',10,'[C@5772b232',0),(33209,'TE',10,'[C@4722a041',0),(33210,'TE',10,'[C@46e45871',0),(33211,'TE',10,'[C@c811350',0),(33212,'TE',10,'[C@4e20d3d0',0),(33213,'TE',10,'[C@1c5252fd',0),(33214,'TE',10,'[C@7891a6d6',0),(33215,'TE',10,'[C@7c8e3107',0),(33216,'TE',10,'[C@3478c315',0),(33217,'TE',10,'[C@3a33aadd',0),(33218,'TE',10,'[C@4fe11c5b',0),(33219,'TE',10,'[C@426a1aa9',0),(33220,'TE',10,'[C@3078099a',0),(33221,'TE',10,'[C@17ba380a',0),(33222,'TE',10,'[C@50fefd62',0),(33223,'TE',10,'[C@42d31a86',0),(33224,'TE',10,'[C@3297ef9f',0),(33225,'TE',10,'[C@742bebaf',0),(33226,'TE',10,'[C@53991da5',0),(33227,'TE',10,'[C@9c42a7a',0),(33228,'TE',10,'[C@422c7ca',0),(33229,'TE',10,'[C@2f7f3272',0),(33230,'TE',10,'[C@3410660d',0),(33231,'TE',10,'[C@1c2f1d0f',0),(33232,'TE',10,'[C@ea195d7',0),(33233,'TE',10,'[C@581bcad3',0),(33234,'TE',10,'[C@6f0cffd3',0),(33235,'TE',10,'[C@baf4058',0),(33236,'TE',10,'[C@92273d7',0),(33237,'TE',10,'[C@f696d72',0),(33238,'TE',10,'[C@713f92b',0),(33239,'TE',10,'[C@764fc411',0),(33240,'TE',10,'[C@6ce9bdc4',0),(33241,'TE',10,'[C@28af4fd6',0),(33242,'TE',10,'[C@306d3149',0),(33243,'TE',10,'[C@380a1419',0),(33244,'TE',10,'[C@192c8941',0),(33245,'TE',10,'[C@4bafa44d',0),(33246,'TE',10,'[C@12113308',0),(33247,'TE',10,'[C@7ad3478f',0),(33248,'TE',10,'[C@7c8af15',0),(33249,'TE',10,'[C@3173ee6d',0),(33250,'TE',10,'[C@2a611238',0),(33251,'TE',10,'[C@4a6ed7c4',0),(33252,'TE',10,'[C@89c699b',0),(33253,'TE',10,'[C@2632ee63',0),(33254,'TE',10,'[C@460d84f',0),(33255,'TE',10,'[C@388cfff0',0),(33256,'TE',10,'[C@53b799cb',0),(33257,'TE',10,'[C@62c73428',0),(33258,'TE',10,'[C@60672a9f',0),(33259,'TE',10,'[C@3f4b3a1c',0),(33260,'TE',10,'[C@505d95ff',0),(33261,'TE',10,'[C@be09da8',0),(33262,'TE',10,'[C@520a7d99',0),(33263,'TE',10,'[C@3477261e',0),(33264,'TE',10,'[C@8b9bf02',0),(33265,'TE',10,'[C@7bb6e60',0),(33266,'TE',10,'[C@6dc3dbb',0),(33267,'TE',10,'[C@b16bca8',0),(33268,'TE',10,'[C@4e925367',0),(33269,'TE',10,'[C@1286ecbb',0),(33270,'TE',10,'[C@75d03ab5',0),(33301,'TE',11,'[C@4b9d3b5b',0),(33302,'TE',11,'[C@17c84024',0),(33303,'TE',11,'[C@320e8552',0),(33304,'TE',11,'[C@46ff0434',0),(33305,'TE',11,'[C@649aa853',0),(33306,'TE',11,'[C@31860d84',0),(33307,'TE',11,'[C@77642af3',0),(33308,'TE',11,'[C@49045e8f',0),(33309,'TE',11,'[C@786dafcc',0),(33310,'TE',11,'[C@79066768',0),(33311,'TE',11,'[C@2f63f909',0),(33312,'TE',11,'[C@44783a4c',0),(33313,'TE',11,'[C@517eeec0',0),(33314,'TE',11,'[C@1b89fea0',0),(33315,'TE',11,'[C@2b92f769',0),(33316,'TE',11,'[C@2ebd020d',0),(33317,'TE',11,'[C@813f1f4',0),(33318,'TE',11,'[C@5cbb72a8',0),(33319,'TE',11,'[C@602effe9',0),(33320,'TE',11,'[C@26c5348b',0),(33321,'TE',11,'[C@31cefdf6',0),(33322,'TE',11,'[C@36e7f755',0),(33323,'TE',11,'[C@212187d7',0),(33324,'TE',11,'[C@2e4f9e14',0),(33325,'TE',11,'[C@68a8e766',0),(33326,'TE',11,'[C@617ce879',0),(33327,'TE',11,'[C@4cced4be',0),(33328,'TE',11,'[C@1ea35c0d',0),(33329,'TE',11,'[C@311f0b68',0),(33330,'TE',11,'[C@37260212',0),(33331,'TE',11,'[C@d775b6c',0),(33332,'TE',11,'[C@9b03dfb',0),(33333,'TE',11,'[C@40bd33ee',0),(33334,'TE',11,'[C@470c9f79',0),(33335,'TE',11,'[C@709710cf',0),(33336,'TE',11,'[C@7840b4c3',0),(33337,'TE',11,'[C@51cbda66',0),(33338,'TE',11,'[C@729f6071',0),(33339,'TE',11,'[C@3ac61785',0),(33340,'TE',11,'[C@475d5ab2',0),(33341,'TE',11,'[C@48caa0d5',0),(33342,'TE',11,'[C@41dfcd55',0),(33343,'TE',11,'[C@4baf80d4',0),(33344,'TE',11,'[C@668acbd9',0),(33345,'TE',11,'[C@7bdb13d5',0),(33346,'TE',11,'[C@44d1cc9e',0),(33347,'TE',11,'[C@734f5df0',0),(33348,'TE',11,'[C@432b9443',0),(33349,'TE',11,'[C@60cd6248',0),(33350,'TE',11,'[C@2a32f7f3',0),(33351,'TE',11,'[C@231b9f98',0),(33352,'TE',11,'[C@3c8d9e34',0),(33353,'TE',11,'[C@37d964cf',0),(33354,'TE',11,'[C@a6990a8',0),(33355,'TE',11,'[C@75713922',0),(33356,'TE',11,'[C@255d7586',0),(33357,'TE',11,'[C@59de92fe',0),(33358,'TE',11,'[C@1ff4a5bd',0),(33359,'TE',11,'[C@63b02748',0),(33360,'TE',11,'[C@2d8f9ffd',0),(33361,'TE',11,'[C@6ba1d0',0),(33362,'TE',11,'[C@3a88352d',0),(33363,'TE',11,'[C@58e0df53',0),(33364,'TE',11,'[C@941c3c5',0),(33365,'TE',11,'[C@5479861c',0),(33366,'TE',11,'[C@2f23f0e3',0),(33367,'TE',11,'[C@71e7a813',0),(33368,'TE',11,'[C@76bf0201',0),(33369,'TE',11,'[C@6e6e33ac',0),(33370,'TE',11,'[C@5efa726a',0),(33371,'TE',11,'[C@1291ee96',0),(33372,'TE',11,'[C@1c3059cf',0),(33373,'TE',11,'[C@3dceab6',0),(33374,'TE',11,'[C@e38b185',0);";
	String query40 = "UNLOCK TABLES;";
	
	String query41 = "DROP TABLE IF EXISTS student_cat;";
	
	String query42 = "CREATE TABLE student_cat ("+
			  "rollno int(11) NOT NULL,"+
			  "tid int(11) NOT NULL,"+
			  "sid int(11) NOT NULL,"+
			  "fc int(11) DEFAULT '0',"+
			  "PRIMARY KEY (rollno,tid,sid),"+
			  "KEY tid (tid),"+
			  "KEY sid (sid)"+
			");";
	
	String query43 = "LOCK TABLES student_cat WRITE;";
	
	//String query44 = "INSERT INTO student_cat VALUES (33121,22,4,0),(33122,22,4,0),(33123,22,4,0),(33124,22,4,0),(33125,22,4,0),(33126,22,4,0),(33127,22,4,0),(33128,22,4,0),(33129,22,4,0),(33130,22,4,0),(33131,22,4,0),(33132,22,4,0),(33133,22,4,0),(33134,22,4,0),(33135,22,4,0),(33136,22,4,0),(33137,22,4,0),(33138,22,4,0),(33139,22,4,0),(33140,22,4,0),(33141,22,4,0),(33142,22,4,0),(33143,22,4,0),(33144,22,4,0),(33145,22,4,0),(33146,22,4,0),(33147,22,4,0),(33148,22,4,0),(33149,22,4,0),(33150,22,4,0),(33151,22,4,0),(33152,22,4,0),(33153,22,4,0),(33154,22,4,0),(33155,22,4,0),(33156,22,4,0),(33157,22,4,0),(33158,22,4,0),(33159,22,4,0),(33160,22,4,0),(33201,25,3,0),(33202,25,3,0),(33203,25,3,0),(33204,25,3,0),(33205,25,3,0),(33206,25,3,0),(33207,25,3,0),(33208,25,3,0),(33209,25,3,0),(33210,25,3,0),(33211,25,3,0),(33212,25,3,0),(33213,25,3,0),(33214,25,3,0),(33215,25,3,0),(33216,25,3,0),(33217,25,3,0),(33218,25,3,0),(33237,25,3,0),(33238,25,3,0),(33239,25,3,0),(33240,25,3,0),(33241,25,3,0),(33242,25,3,0),(33243,25,3,0),(33244,25,3,0),(33245,25,3,0),(33246,25,3,0),(33247,25,3,0),(33248,25,3,0),(33249,25,3,0),(33250,25,3,0),(33251,25,3,0),(33252,25,3,0),(33253,25,3,0),(33254,25,3,0),(33301,21,3,1),(33301,24,4,1),(33302,21,3,0),(33302,24,4,0),(33303,21,3,0),(33303,24,4,0),(33304,21,3,0),(33304,24,4,0),(33305,21,3,0),(33305,24,4,0),(33306,21,3,0),(33306,24,4,0),(33307,21,3,0),(33307,24,4,0),(33308,21,3,0),(33308,24,4,0),(33309,21,3,0),(33309,24,4,0),(33310,21,3,0),(33310,24,4,0),(33311,21,3,0),(33311,24,4,0),(33312,21,3,0),(33312,24,4,0),(33313,21,3,0),(33313,24,4,0),(33314,21,3,0),(33314,24,4,0),(33315,21,3,0),(33315,24,4,0),(33316,21,3,0),(33316,24,4,0),(33317,21,3,0),(33317,24,4,0),(33318,21,3,0),(33318,24,4,0),(33319,21,3,0),(33319,21,6666,0),(33319,24,8888,0),(33320,21,3,0),(33320,21,6666,0),(33320,24,8888,0),(33321,21,3,0),(33321,21,6666,0),(33321,24,8888,0),(33322,21,3,0),(33322,21,6666,0),(33322,24,8888,0),(33323,21,3,0),(33323,21,6666,0),(33323,24,8888,0),(33324,21,3,0),(33324,21,6666,0),(33324,24,8888,0),(33325,21,3,0),(33325,21,6666,0),(33325,24,8888,0),(33326,21,3,0),(33326,21,6666,0),(33326,24,8888,0),(33327,21,3,0),(33327,21,6666,0),(33327,24,8888,0),(33328,21,3,0),(33328,21,6666,0),(33328,24,8888,0),(33329,21,3,0),(33329,21,6666,0),(33329,24,8888,0),(33330,21,3,0),(33330,21,6666,0),(33330,24,8888,0),(33331,21,3,0),(33331,21,6666,0),(33331,24,8888,0),(33332,21,3,0),(33332,21,6666,0),(33332,24,8888,0),(33333,21,3,0),(33333,21,6666,0),(33333,24,8888,0),(33334,21,3,0),(33334,21,6666,0),(33334,24,8888,0),(33335,21,3,0),(33335,21,6666,0),(33335,24,8888,0),(33336,21,3,0),(33336,21,6666,0),(33336,24,8888,0),(33337,21,3,0),(33337,24,4,0),(33338,21,3,0),(33338,24,4,0),(33339,21,3,0),(33339,24,4,0),(33340,21,3,0),(33340,24,4,0),(33341,21,3,0),(33341,24,4,0),(33342,21,3,0),(33342,24,4,0),(33343,21,3,0),(33343,24,4,0),(33344,21,3,0),(33344,24,4,0),(33345,21,3,0),(33345,24,4,0),(33346,21,3,0),(33346,24,4,0),(33347,21,3,0),(33347,24,4,0),(33348,21,3,0),(33348,24,4,0),(33349,21,3,0),(33349,24,4,0),(33350,21,3,0),(33350,24,4,0),(33351,21,3,0),(33351,24,4,0),(33352,21,3,0),(33352,24,4,0),(33353,21,3,0),(33353,24,4,0),(33354,21,3,0),(33354,24,4,0);";
	
	String query45 = "UNLOCK TABLES;";
	
	String query46 = "DROP TABLE IF EXISTS subject;";
	
	String query47 = "CREATE TABLE subject ("+
			  "subject_id int(11) NOT NULL,"+
			  "subject_name varchar(255) NOT NULL,"+
			  "dept_id varchar(20) DEFAULT NULL,"+
			  "yr char(2) DEFAULT NULL,"+
			  "domain_name varchar(20) DEFAULT NULL,"+
			  "PRIMARY KEY (subject_id),"+
			  "KEY domain_name (domain_name),"+
			  "KEY dept_id (dept_id),"+
			  "CONSTRAINT subject_ibfk_1 FOREIGN KEY (domain_name) REFERENCES domain (domain_name) ON DELETE CASCADE ON UPDATE CASCADE,"+
			  "CONSTRAINT subject_ibfk_2 FOREIGN KEY (dept_id) REFERENCES dept (dept_name) ON DELETE CASCADE ON UPDATE CASCADE"+
			");";
			
	String query48 = "LOCK TABLES subject WRITE;";
	
	//String query49 = "INSERT INTO subject VALUES (1,'OS','IT','TE','CTL'),(2,'DBMS','IT','TE','CTL'),(3,'SLI','IT','TE','LTL'),(4,'SLII','IT','TE','LTL'),(111,'jojo','IT','SE','CTL'),(420,'SAM','IT','SE','CTL'),(12345,'DB','IT','TE','CTL');";
	String query50 = "UNLOCK TABLES;";
	
	String query51 = "DROP TABLE IF EXISTS teacher_class_subject;";
	
	String query52 = "CREATE TABLE teacher_class_subject ("+
			  "cat_id int(11) NOT NULL AUTO_INCREMENT,"+
			  "tid int(11) DEFAULT NULL,"+
			  "cid_year char(2) DEFAULT NULL,"+
			  "cid_div int(11) DEFAULT NULL,"+
			  "sid int(11) DEFAULT NULL,"+
			  "PRIMARY KEY (cat_id),"+
			  "KEY tid (tid),"+
			  "KEY cid_year (cid_year,cid_div),"+
			  "KEY sid (sid),"+
			  "CONSTRAINT teacher_class_subject_ibfk_1 FOREIGN KEY (tid) REFERENCES teachers (id) ON DELETE CASCADE ON UPDATE CASCADE,"+
			  "CONSTRAINT teacher_class_subject_ibfk_2 FOREIGN KEY (cid_year, cid_div) REFERENCES class (year, division) ON DELETE CASCADE ON UPDATE CASCADE,"+
			  "CONSTRAINT teacher_class_subject_ibfk_3 FOREIGN KEY (sid) REFERENCES subject (subject_id) ON DELETE CASCADE ON UPDATE CASCADE"+
			");";
	
	String query53 = "LOCK TABLES teacher_class_subject WRITE;";
	
	//String query54 = "INSERT INTO teacher_class_subject VALUES (12,26,'TE',10,2),(13,25,'TE',10,3),(14,23,'TE',9,12345),(15,19,'TE',9,1),(16,22,'TE',9,4),(17,19,'SE',3,420),(18,21,'SE',3,111),(19,20,'TE',11,2),(20,19,'TE',11,1),(21,21,'TE',11,3);";
	
	String query55 = "UNLOCK TABLES;";
	
	String query56 = "DROP TABLE IF EXISTS teacher_subject_template;";
	
	String query57 = "CREATE TABLE teacher_subject_template ("+
			  "tid int(11) DEFAULT NULL,"+
			  "sid int(11) DEFAULT NULL,"+
			  "temp_id varchar(20) DEFAULT NULL,"+
			  "KEY tid (tid),"+
			  "KEY sid (sid),"+
			  "KEY temp_id (temp_id),"+
			  "CONSTRAINT teacher_subject_template_ibfk_1 FOREIGN KEY (tid) REFERENCES teachers (id) ON DELETE CASCADE ON UPDATE CASCADE,"+
			  "CONSTRAINT teacher_subject_template_ibfk_2 FOREIGN KEY (sid) REFERENCES subject (subject_id) ON DELETE CASCADE ON UPDATE CASCADE,"+
			  "CONSTRAINT teacher_subject_template_ibfk_3 FOREIGN KEY (temp_id) REFERENCES template (temp_name) ON DELETE CASCADE ON UPDATE CASCADE"+
			");";
			
	String query58 = "LOCK TABLES teacher_subject_template WRITE;";
	
	//String query59 = "INSERT INTO teacher_subject_template VALUES (19,1,'CTL'),(20,2,'CTL'),(26,2,'CTL'),(25,3,'LTL'),(22,4,'LTL'),(19,1,'CTL'),(21,3,'LTL');";
	
	String query60 = "UNLOCK TABLES;";
	
	String query61 = "DROP TABLE IF EXISTS teachers;";
	
	String query62 = "CREATE TABLE teachers ("+
			  "id int(11) NOT NULL AUTO_INCREMENT,"+
			  "dept varchar(30) DEFAULT NULL,"+
			  "name varchar(45) DEFAULT NULL,"+
			  "PRIMARY KEY (id),"+
			  "KEY dept (dept),"+
			  "CONSTRAINT teachers_ibfk_1 FOREIGN KEY (dept) REFERENCES dept (dept_name) ON DELETE CASCADE ON UPDATE CASCADE"+
			");";
	String query63 = "LOCK TABLES teachers WRITE;";
	
	//String query64 = "INSERT INTO teachers VALUES (19,'IT','Buradkar'),(20,'IT','Murumkar'),(21,'IT','Kamble'),(22,'IT','Dharmadhikari'),(23,'IT','Londhe'),(24,'IT','Chhajed'),(25,'IT','Jakhete'),(26,'IT','Pande');";
	
	String query65 = "UNLOCK TABLES;";
	
	String query66 = "DROP TABLE IF EXISTS temp_ques;";
	
	String query67 = "CREATE TABLE temp_ques ("+
			  "temp_id varchar(20) DEFAULT NULL,"+
			  "qid int(11) DEFAULT NULL,"+
			  "KEY temp_id (temp_id),"+
			  "KEY qid (qid),"+
			  "CONSTRAINT temp_ques_ibfk_1 FOREIGN KEY (temp_id) REFERENCES template (temp_name) ON DELETE CASCADE ON UPDATE CASCADE,"+
			  "CONSTRAINT temp_ques_ibfk_2 FOREIGN KEY (qid) REFERENCES question (qid) ON DELETE CASCADE ON UPDATE CASCADE"+
			");";
	
	String query68 = "LOCK TABLES temp_ques WRITE;";
	
	String queryF1 = "alter table studcheck add foreign key(rollno) references student(rollno);";
	String queryF2= "alter table student_cat add foreign key(rollno) references student(rollno);";
	String query70 = "UNLOCK TABLES;";
	
	String query71 = "DROP TABLE IF EXISTS template;";
	
	String query72 = "CREATE TABLE template ("+
			  "temp_name varchar(20) NOT NULL,"+
			  "PRIMARY KEY (temp_name)"+
			");";
	
	String query73 = "LOCK TABLES template WRITE;";
	
	//String query74 = "INSERT INTO template VALUES ('CTL'),('LTL');";
	
	String query75 = "UNLOCK TABLES;";
	
	String trig1 = "DELIMITER ;; "+
			"CREATE TRIGGER 'c_stud' "+ 
			"AFTER INSERT ON 'class' "+
			"FOR EACH ROW "+ 
			"begin declare r1 int; "+ 
			"declare r2 int; "+ 
			"set r1 = new.ran1; "+ 
			"set r2 = new.ran2; "+ 
			"while r1<= r2 do "+ 
			"insert into student(rollno,year,division) values(r1,new.year,new.division); "+ 
			"set r1 = r1 + 1; "+ 
			"end while; "+ 
			"end ;; "+
			"DELIMITER ;";
	
	String trig2 = "DELIMITER ;; "+
			"CREATE TRIGGER 'class_BEFORE_DELETE' "+ 
			"BEFORE DELETE ON 'class' "+ 
			"FOR EACH ROW "+ 
			"BEGIN "+
			 "delete from student where year=old.year and division=old.division; "+
			"END ;; "+
			"DELIMITER ;";
						
	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
	} catch (ClassNotFoundException e) {
		out.println("Class not found: " + e.getMessage());
		return;
	}
	try {
		connection = DriverManager.getConnection(url, username, password);
		statement = connection.createStatement();
		statement2 = connection.createStatement();
		statement3 = connection.createStatement();
		
		out.println("<b>List of databases accessible by user " + username + ":</b><br/>");
		rset = statement.executeQuery("SHOW DATABASES");
		while (rset.next()) {
			out.println(rset.getString(1) + "<br/>");
		}
		rset.close();
		out.println("<hr>");
		
%>

<form action="createNewDB.jsp" method="post" name="myDBForm">
		<label>Select Year</label> 
		<select name="select_year" id="select_year" onchange = "document.forms['myDBForm'].submit();">
		</select> 
		<script>
			(function() {
			    var elm = document.getElementById('select_year'),
			        df = document.createDocumentFragment();
			    for (var i = (new Date().getFullYear())-10; i <= (new Date().getFullYear())+10; i++) {
			    	for (var j=1;j<=2;j++) {
				        var option = document.createElement('option');
				        option.value = i + "_" + (i+1)+"_sem"+j;
				        option.appendChild(document.createTextNode(i+" _ "+(i+1)+"_sem"+j));
				        df.appendChild(option);
			    	}
			    }
			    elm.appendChild(df);
			}());
		</script>
		
		<input type="submit" name="Create" value="Create"> 
		<input type="submit" name="Drop" value="Drop"> 
		<input type="submit" name="Use" value="Use">
		<input type="reset" name="Reset" value="Reset">
</form>

<%
if (request.getParameter("select_year") != null) {
	database = (String) "feedback_main_" + request.getParameter("select_year");
	if (request.getParameter("Create") != null && request.getParameter("Create").equals("Create")) {
		rnew = statement.executeQuery("SHOW DATABASES LIKE '"+database+"'");		
		if (rnew.next() ) {
			out.println("Database already exists!!!!!");
		}
		else{
			result = statement.executeUpdate("CREATE DATABASE " + database);
			result2 = statement2.executeUpdate("USE " + database);
			//result3 = statement3.executeUpdate("SOURCE "+schema_path);
			
			result3 = statement3.executeUpdate(query1);
			result3 = statement3.executeUpdate(query2);
			result3 = statement3.executeUpdate(query3);
			result3 = statement3.executeUpdate(query4);
			result3 = statement3.executeUpdate(query5);
			
			result3 = statement3.executeUpdate(query11);
			result3 = statement3.executeUpdate(query12);
			result3 = statement3.executeUpdate(query13);
			result3 = statement3.executeUpdate(query14);
			result3 = statement3.executeUpdate(query15);
			
			result3 = statement3.executeUpdate(query6);
			result3 = statement3.executeUpdate(query7);
			result3 = statement3.executeUpdate(query8);
		//	result3 = statement3.executeUpdate(query9);
			result3 = statement3.executeUpdate(query10);
			
			result3 = statement3.executeUpdate(query16);
			result3 = statement3.executeUpdate(query17);
			result3 = statement3.executeUpdate(query18);
			//result3 = statement3.executeUpdate(query19);
			result3 = statement3.executeUpdate(query20);
			
			result3 = statement3.executeUpdate(query61);
			result3 = statement3.executeUpdate(query62);
			result3 = statement3.executeUpdate(query63);
			//result3 = statement3.executeUpdate(query64);
			result3 = statement3.executeUpdate(query65);
			
			
			result3 = statement3.executeUpdate(query46);
			result3 = statement3.executeUpdate(query47);
			result3 = statement3.executeUpdate(query48);
			//result3 = statement3.executeUpdate(query49);
			result3 = statement3.executeUpdate(query50);
			
			result3 = statement3.executeUpdate(query51);
			result3 = statement3.executeUpdate(query52);
			result3 = statement3.executeUpdate(query53);
			//result3 = statement3.executeUpdate(query54);
			result3 = statement3.executeUpdate(query55);
			
			result3 = statement3.executeUpdate(query21);
			result3 = statement3.executeUpdate(query22);
			result3 = statement3.executeUpdate(query23);
			//result3 = statement3.executeUpdate(query24);
			result3 = statement3.executeUpdate(query25);
			
			result3 = statement3.executeUpdate(query26);
			result3 = statement3.executeUpdate(query27);
			result3 = statement3.executeUpdate(query28);
			//result3 = statement3.executeUpdate(query29);
			result3 = statement3.executeUpdate(query30);
			result3 = statement3.executeUpdate(query31);
			result3 = statement3.executeUpdate(query32);
			result3 = statement3.executeUpdate(query33);
			//result3 = statement3.executeUpdate(query34);
			result3 = statement3.executeUpdate(query35);
			result3 = statement3.executeUpdate(query36);
			result3 = statement3.executeUpdate(query37);
			result3 = statement3.executeUpdate(query38);
			//result3 = statement3.executeUpdate(query39);
			result3 = statement3.executeUpdate(query40);
			result3 = statement3.executeUpdate(query41);
			result3 = statement3.executeUpdate(query42);
			result3 = statement3.executeUpdate(query43);
			//result3 = statement3.executeUpdate(query44);
			result3 = statement3.executeUpdate(query45);
			
			result3 = statement3.executeUpdate(query71);
			result3 = statement3.executeUpdate(query72);
			result3 = statement3.executeUpdate(query73);
			//result3 = statement3.executeUpdate(query74);
			result3 = statement3.executeUpdate(query75);
			
			result3 = statement3.executeUpdate(query56);
			result3 = statement3.executeUpdate(query57);
			result3 = statement3.executeUpdate(query58);
			//result3 = statement3.executeUpdate(query59);
			result3 = statement3.executeUpdate(query60);
			
			result3 = statement3.executeUpdate(queryF1);
			result3 = statement3.executeUpdate(queryF2);
			result3 = statement3.executeUpdate(query66);
			result3 = statement3.executeUpdate(query67);
			result3 = statement3.executeUpdate(query68);
			//result3 = statement3.executeUpdate(query69);
			result3 = statement3.executeUpdate(query70);
			
			//System.out.print("Executed db statements\nExecuting triggers now\n");
			
			//result3 = statement3.executeUpdate(trig1);
			//result3 = statement3.executeUpdate(trig2);
			
			//System.out.println("Triggers executed successfully");
			
			out.println("result of 'CREATE DATABASE '" + database + " is " + result);
			databaseListChanged = true;
			rnew.close();
		}
	} else if (request.getParameter("Drop") != null && request.getParameter("Drop").equals("Drop")) {
		result = statement.executeUpdate("DROP DATABASE " + database);
		out.println("result of 'DROP DATABASE '" + database + " is " + result);
		databaseListChanged = true;
	} else if (request.getParameter("Use") != null && request.getParameter("Use").equals("Use")) {
		result = statement.executeUpdate("USE " + database);
		out.println("<b>result of USE " + database + " is " + result + "<b><br />");
		curdb = statement2.executeQuery("Select database()");
		while (curdb.next()) {
			out.println("<b>Current db in use is " + curdb.getString(1) + "</b><br/>");
		}
		curdb.close();
		out.println("<hr>");
		usedbflag = true;
		databaseListChanged = true;
	}
	session.setAttribute("database", database);
}
statement.close();
statement2.close();
connection.close();
if (databaseListChanged) {
	//response.sendRedirect(request.getRequestURL().toString() + "?result=" + result);
	response.sendRedirect("Login.html");
}
if (usedbflag) {
	System.out.println(database + " is in use !!!");
	out.println("Current database in use is " + request.getParameter("database") + "<br/>");
}
/* if (request.getParameter("result") != null) {
	out.println("result of last CREATE or DROP or Use database is " + request.getParameter("result")
			+ "<br/>");
} */
%>

<%
	} catch (SQLException e) {
		out.println(e.getMessage());
	} finally {
		try {
			if (connection != null)
				connection.close();
		} catch (SQLException e) {
		}
	}
%>

<script src="/1st_increment_feedback/js/jquery.js"></script>
<script>
$(document).ready(function(){
$("#select_year").val("<%=year%>")
});
</script>