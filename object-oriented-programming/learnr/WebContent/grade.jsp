<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@page import="java.sql.*,java.util.*"%>

<html>
<head>
<title>LearnR | Grade</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="css/main.css" />
</head>
<body>
<%
/* My source for most of this code:
   http://www.webmasterbase.com/article/770/565 */

// Define variables
int qid = Integer.parseInt((request.getParameter("qid")).trim());
int a[] = {0, 0, 0, 0, 0}, marks = 0;
a[0] = Integer.parseInt((request.getParameter("a1")));
a[1] = Integer.parseInt((request.getParameter("a2")));
a[2] = Integer.parseInt((request.getParameter("a3")));
a[3] = Integer.parseInt((request.getParameter("a4")));
a[4] = Integer.parseInt((request.getParameter("a5")));
ArrayList<String> ans=new ArrayList<String>();
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
String query = "SELECT ans FROM quiz where qid='"+qid+"'";
//Bind values
//  prepStmt = conn.prepareStatement(query);
//  prepStmt.setString(1, url);
// Get the query results and display them.
ResultSet sqlResult = sqlStatement.executeQuery(query);

while(sqlResult.next()) {
	ans.add(sqlResult.getString("ans"));
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

		<form action="user.jsp" method="post">
			<h3>
			<%
			for (int i = 0; i < ans.size(); i++) {
				if (Integer.parseInt(ans.get(i)) == a[i])
					marks += 2;
			}
			
			try
			{
			Class.forName("com.mysql.jdbc.Driver");
			Statement st=conn.createStatement();

			int i=st.executeUpdate("insert into marks(id, qid, score, uid)values(1,'"+qid+"','"+marks+"',1)");
			out.println("You obtained "+marks+" marks out of "+ (2*ans.size()));
			}
			catch(Exception e)
			{
			System.out.print(e);
			e.printStackTrace();
			}
			%>
			</h3>

			<imput type="hidden" name="marks" value=${marks} />
			
			<input type="submit" value="Dashboard" />
		</form>
	</section>
	</div>
	</section>
</body>
</html>