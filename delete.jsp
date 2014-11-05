<%@ page pageEncoding="GB18030"%>
<%@ page import="java.sql.*, com.xiaobo.bbs.*, java.util.*"%>

<%!
private void delete(Connection conn, int id, boolean isLeaf) {
	//delete all the children
	//delete(conn, child's id)
	if (!isLeaf) {
		String sql = "select * from article where pid = " + id;
		Statement stmt = DB.createStmt(conn);
		ResultSet rs = DB.executeQuery(stmt, sql); 
		try {
			while(rs.next()) {
				delete(conn, rs.getInt("id"), rs.getInt("isLeaf")==0);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			
			DB.close(rs);
			DB.close(stmt);
		}
	}
	//delete self
	DB.executeUpdate(conn, "delete from article where id = " + id);
}
%>

<%
//传过来的id有可能是空值，最好要验证一下，否则可能会throw NullPointerException
int id = 0;
String strId = request.getParameter("id");
if (strId == null || strId.trim().equals("")) {
	System.out.println("Null Pointer Exception! id can not be null");
} else {
	id = Integer.parseInt(strId);
}
boolean isLeaf = Boolean.parseBoolean("isLeaf");
int pid = Integer.parseInt(request.getParameter("pid"));
Connection conn = DB.getConn();
delete(conn, id, isLeaf);
DB.close(conn);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Java Programming</title>
<meta http-equiv="content-type" content="text/html; charset=utf8">
<link rel="stylesheet" type="text/css" href="images/style.css" title="Integrated Styles">
<script language="JavaScript" type="text/javascript" src="images/global.js"></script>
<link rel="alternate" type="application/rss+xml" title="RSS" href="http://bbs.chinajavaworld.com/rss/rssmessages.jspa?forumID=20">
<script language="JavaScript" type="text/javascript" src="images/common.js"></script>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td width="40%"><img src="images/header-stretch.gif" alt="" border="0" height="57" width="100%">
     	</td>
      <td width="1%"><img src="images/header-right.gif" alt="" height="57" border="0"></td>
    </tr>
  </tbody>
</table>
<br>
<div id="jive-forumpage">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td width="98%"><p class="jive-breadcrumbs">Forum: Java Programming</p>
          <p class="jive-description"> Share Java study insight and make grogress together. Decline any ad! </p>
          </td>
      </tr>
    </tbody>
  </table>
  <div class="jive-buttons">
    <table summary="Buttons" border="0" cellpadding="0" cellspacing="0">
      <tbody>
        <tr>
          <td class="jive-icon"><a href="post.jsp"><img src="images/post-16x16.gif" alt="Create New Post" border="0" height="16" width="16"></a></td>
          <td class="jive-icon-label"><a id="jive-post-thread" href="post.jsp">Create New Post</a></td>
        </tr>
      </tbody>
    </table>
  </div>
  <br>
  <table border="0" cellpadding="3" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td><span class="nobreak"> Page:
          1,316 - <span class="jive-paginator"> [ <a href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=0&amp;isBest=0">Prev</a> | <a href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=0&amp;isBest=0" class="">1</a> <a href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=25&amp;isBest=0" class="jive-current">2</a> <a href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=50&amp;isBest=0" class="">3</a> <a href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=75&amp;isBest=0" class="">4</a> <a href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=100&amp;isBest=0" class="">5</a> <a href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=125&amp;isBest=0" class="">6</a> | <a href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=50&amp;isBest=0">Next</a> ] </span> </span> </td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td width="99%"><div class="jive-thread-list">
            <div class="jive-table">
              <table summary="List of threads" cellpadding="0" cellspacing="0" width="100%">
                <thead>
                  <tr>
                    <th class="jive-first" colspan="3"> Topic </th>
                    <th class="jive-author"> <nobr> Editor
                      &nbsp; </nobr> </th>
                    <th class="jive-view-count"> <nobr> Views
                      &nbsp; </nobr> </th>
                    <th class="jive-msg-count" nowrap="nowrap"> reply </th>
                    <th class="jive-last" nowrap="nowrap"> Newest Post </th>
                  </tr>
                </thead>
                <tbody>
                <%
                for(Iterator<Article> it = articles.iterator(); it.hasNext(); ) {
                	Article a = it.next();
                	System.out.println(a.getTitle());
                	String preStr = "";
  					for(int i=0; i<a.getGrade(); i++) {
  						preStr += "----";
  					}
                %>
                  <tr class="jive-even">
                    <td class="jive-first" nowrap="nowrap" width="1%"><div class="jive-bullet"> <img src="images/read-16x16.gif" alt="已读" border="0" height="16" width="16">
                        <!-- div-->
                      </div></td>
                      
                    <td nowrap="nowrap" width="1%">
                    	<a href="delete.jsp?id=<%=a.getId()%>&isLeaf=<%=a.isLeaf()%>&pid=<%=a.getPid() %>">DEL</a>
                    </td>
                    
                    
                    <td class="jive-thread-name" width="95%"><a id="jive-thread-1" href="articleDetail.jsp?id=<%=a.getId() %>"><%=preStr + a.getTitle() %></a></td>
                    <td class="jive-author" nowrap="nowrap" width="1%"><span class=""> <a href="http://bbs.chinajavaworld.com/profile.jspa?userID=226030">bjsxt</a> </span></td>
                    <td class="jive-view-count" width="1%"> 10000</td>
                    <td class="jive-msg-count" width="1%"> 0</td>
                    <td class="jive-last" nowrap="nowrap" width="1%"><div class="jive-last-post"> <%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(a.getPdate()) %> <br>
                        by: <a href="http://bbs.chinajavaworld.com/thread.jspa?messageID=780182#780182" title="jingjiangjun" style="">bjsxt &#187;</a> </div></td>
                  </tr>
                  <%--
                  <tr class="jive-odd">
                    <td class="jive-first" nowrap="nowrap" width="1%"><div class="jive-bullet"> <img src="images/read-16x16.gif" alt="已读" border="0" height="16" width="16">
                        <!-- div-->
                      </div></td>
                    <td nowrap="nowrap" width="1%">&nbsp;
                      
                      
                      
                      
                      &nbsp;</td>
                    <td class="jive-thread-name" width="95%"><a id="jive-thread-2" href="http://bbs.chinajavaworld.com/thread.jspa?threadID=744234&amp;tstart=25">请 兄弟们指点下那里 错误，，，</a></td>
                    <td class="jive-author" nowrap="nowrap" width="1%"><span class=""> <a href="http://bbs.chinajavaworld.com/profile.jspa?userID=226028">403783154</a> </span></td>
                    <td class="jive-view-count" width="1%"> 52</td>
                    <td class="jive-msg-count" width="1%"> 2</td>
                    <td class="jive-last" nowrap="nowrap" width="1%"><div class="jive-last-post"> 2007-9-13 上午8:40 <br>
                        by: <a href="http://bbs.chinajavaworld.com/thread.jspa?messageID=780172#780172" title="downing114" style="">downing114 &#187;</a> </div></td>
                  </tr>
                    --%>
                  <%
                  }
                  %>
                </tbody>
              </table>
            </div>
          </div>
          <div class="jive-legend"></div></td>
      </tr>
    </tbody>
  </table>
  <br>
  <br>
</div>
</body>
</html>
