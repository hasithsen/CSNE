<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>LearnR | Sign In</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="css/main.css" />
</head>
<body>

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
		<h1>Sign In to LearnR</h1>
		</header>
		
		<form action="LoginServlet" method="post">
			<input type="text" name="email" placeholder="Email" /> <br />
			<input type="password" name="passwd" placeholder="Password" />  <br />
			<select name="userType">
            <option>Student</option>
            <option>Teacher</option>
       	 	</select> 
			Please note all fields are required. <br /> <br />
			<input type="submit" value="Sign In" /> <br /> <br />
		</form>
		</div>
	</section>
</body>
</html>