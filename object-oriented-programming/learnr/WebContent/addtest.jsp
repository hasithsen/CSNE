<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- These import statements are needed to run the SQL queries, they are
     part of the JDK. -->
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import='java.util.ArrayList' %>
<%-- <%@	include file="test.jsp" %> --%>
<html>
<head>
<title>LearnR | Sign Up</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="css/main.css" />
</head>
<body>

<%!
/* My source for most of this code:
   http://www.webmasterbase.com/article/770/565 */

// Define variables
int id=0;

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
String query = "SELECT id FROM test";

// Get the query results and display them.
ResultSet sqlResult = sqlStatement.executeQuery(query);
while(sqlResult.next()) {
	// get the highest id
	id = Integer.parseInt(sqlResult.getString("id"));
}
// increase id by one to avoid potential erros
id++;
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
		<h1>Sign Up to LearnR</h1>
		</header>
		
		<form action="AddTestServlet" method="post">
			<input type="text" name="q1" placeholder="Question 1" /> <br /> 
			<input type="text" name="q2" placeholder="Question 2" /> <br /> 
			<input type="text" name="q3" placeholder="Question 3" /> <br /> 
			<input type="text" name="q4" placeholder="Question 4" /> <br /> 
			<input type="text" name="q5" placeholder="Question 5" /> <br />
			<input type="hidden" name="id" value=<%=id%> /> <br />
			<input type="submit" value="Add Test" />
		</form>
	</section>
	</div>
	</section>
</body>
</html>