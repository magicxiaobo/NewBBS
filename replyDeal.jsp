<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
    
<% 
request.setCharacterEncoding("GBK");
String title = request.getParameter("title");
System.out.println(title);
String cont = request.getParameter("cont");
System.out.println(cont);
Connection conn = DB.getConn();
String sql = "insert into article values (null, ?, ?, ?, ?, now(), ?)";
PreparedStatement pstmt = DB.prepareStmt(conn, sql);
pstmt.executeUpdate();
DB.close(pstmt);
DB.close(conn);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
</head>
<body>

</body>
</html>