<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import = "java.sql.*, com.xiaobo.bbs.*" %>
    
<% 
request.setCharacterEncoding("GBK");

int pid = Integer.parseInt(request.getParameter("pid"));
int rootId = Integer.parseInt(request.getParameter("rootId"));

String title = request.getParameter("title");
System.out.println(title);
String cont = request.getParameter("cont");
System.out.println(cont);

Connection conn = DB.getConn();
String sql = "insert into article values (null, ?, ?, ?, ?, now(), ?)";
PreparedStatement pstmt = DB.prepareStmt(conn, sql);
pstmt.setInt(1, pid);
pstmt.setInt(2, rootId);
pstmt.setString(3, title);
pstmt.setString(4, cont);
pstmt.setInt(5, 0);
pstmt.executeUpdate();

DB.close(pstmt);		//���ﲻ��Ҫ��DB.java��ΪPreparedStatement��������close method��ֱ����Statement��close method�Ϳ��ԡ���ΪPreparedStatement extends Statement
DB.close(conn);

%>

<span id="time" style="background:red">5</span>���Ӻ��Զ���ת���������ת��������������

<script language="JavaScript1.2" type="text/javascript">
<!--
//  Place this in the 'head' section of your page.  

function delayURL(url) {
	var delay = document.getElementById("time").innerHTML;
//alert(delay);
	if(delay > 0) {
		delay--;
		document.getElementById("time").innerHTML = delay;
	} else {
		window.top.location.href = url;
    }
    setTimeout("delayURL('" + url + "')", 1000); //delayURL(http://wwer)
}

//-->

</script>


<a href="article.jsp">�����б�</a>
<script type="text/javascript">
	delayURL("article.jsp");
</script>