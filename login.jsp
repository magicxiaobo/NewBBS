
<%@ page pageEncoding="GB18030"%>
<%@ page import="java.sql.*,com.xiaobo.bbs.*"%>

<%@ taglib uri="http://ckeditor.com" prefix="ckeditor" %>

<%
	request.setCharacterEncoding("GBK");
	String action = request.getParameter("action");
	String username = "";
	if (action != null && action.trim().equals("login")) {
		username = request.getParameter("username");
		System.out.println(username);
		String password = request.getParameter("password");
		System.out.println(password);
		
		if (username == null || !username.trim().equals("admin")) {
			System.out.println("usesrname is not correct!");
		} else if (password == null || !password.trim().equals("admin")) {
			System.out.println("password is not correct!");
		} else {
			session.setAttribute("adminLogined", "true");
			response.sendRedirect("articleFlat.jsp");
		}
	}
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>Administrater Login</title>
</head>
<body>

                	<form action="login.jsp" method="post">
                		<input type="hidden" name="action" value="login">
                		Username:<input type="text" name="username" value="<%=username %>" ><br>
                		Password:<input type="text" name="password" >
                		<br>
                		<input type="submit" value="submit"/>
                	</form>
                	
               
</body>
</html>
