<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import='java.util.ArrayList' %>

<html>
<head>
<title>LearnR | Test</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="css/main.css" />
</head>
<body>
<%
/* My source for most of this code:
   http://www.webmasterbase.com/article/770/565 */

// Define variables
int i=0;
int qid = Integer.parseInt((request.getParameter("qid")).trim());
//int uid = Integer.parseInt((request.getParameter("uid")).trim());
ArrayList<String> quest=new ArrayList<String>();
%>
<%
// This is needed to use Connector/J. It basically creates a new instance
// of the Connector/J jdbc driver.
Class.forName("com.mysql.jdbc.Driver").newInstance();

// Open new connection.
java.sql.Connection conn;
/* To connect to the database, you need to use a JDBC url with the following 
   format ([xxx] denotes optional url components):
   jdbc:mysql://[hostname][:port]/[dbname][?param1=value1][&param2=value2]... 
   By default MySQL's hostname is "localhost." The database used here is 
   called "mydb" and MySQL's default user is "root". If we had a database 
   password we would add "&password=xxx" to the end of the url.
*/
conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/learnr","root", "m0sf3t");
Statement sqlStatement = conn.createStatement();

// Generate the SQL query.
String query = "SELECT quest FROM quiz where qid='"+qid+"'";
//Bind values
//  prepStmt = conn.prepareStatement(query);
//  prepStmt.setString(1, url);
// Get the query results and display them.
ResultSet sqlResult = sqlStatement.executeQuery(query);

while(sqlResult.next()) {
	quest.add(sqlResult.getString("quest"));
}
%>
	<!-- Header -->
	<header id="header">
	<div class="inner">
		<a href="index.html" class="logo"><strong>LearnR</strong> Simple eLearning Platform</a>
		<nav id="nav"> 						
		<a href="index.html">About</a>
		<a href="signup.jsp">Sign Up</a>
		<a href="signin.jsp">Sign In</a>
		</nav>
		<a href="#navPanel" class="navPanelToggle">
		<span class="fa fa-bars"></span></a>
	</div>
	</header>

	<!-- Banner -->
	<section id="banner">
	<div class="inner">
		<header>
		<h1>Test </h1>
		</header>
		
		<form action="grade.jsp" method="post">
			<h3>
			<%
			out.println("Q"+(i+1)+". "+quest.get(i));
			i++;
			%>
			</h3>
			<input type="text" name="a1" placeholder="Answer" /> <br /> 
			
			<h3>
			<%
			out.println("Q"+(i+1)+". "+quest.get(i));
			i++;
			%>
			</h3>
			<input type="text" name="a2" placeholder="Answer" /> <br /> 
			
			<h3>
			<%
			out.println("Q"+(i+1)+". "+quest.get(i));
			i++;
			%>
			</h3>
			<input type="text" name="a3" placeholder="Answer" /> <br /> 
			
			<h3>
			<%
			out.println("Q"+(i+1)+". "+quest.get(i));
			i++;
			%>
			</h3>
			<input type="text" name="a4" placeholder="Answer" /> <br /> 
			
			<h3>
			<%
			out.println("Q"+(i+1)+". "+quest.get(i));
			i++;
			%>
			</h3>
			<input type="text" name="a5" placeholder="Answer" /> <br />
			
			<input type="hidden" name="qid" value=<%=qid%> /> <br />
			<input type="submit" value="Grade Test" />
		</form>
	</section>
	</div>
	</section>
</body>
</html>