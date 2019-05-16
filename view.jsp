<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/basicjsp";
	String id = "jspid";
	String pass = "jsppass";
	int idx = Integer.parseInt(request.getParameter("idx")); //넘어오는 데이터타입은 항상 string이므로 데이터를 변환해주어야 한다.
	//윗줄은 view.jsp에서 get방식으로 idx값을 보낸것을 기억하며 그 변수가 getParameter("idx") 이곳에 들어간 것이며 그 값을 idx에 넣었다.
	//하지만 post든 get방식이든 넘어오게 되면 데이터타입이 String이 되므로 형변환으로 int형으로 변환하는 integer.parseint를 사용한다.
	try {
		
		Connection conn = DriverManager.getConnection(url,id,pass);
		Statement stmt = conn.createStatement();
		
		String sql = "SELECT username, title, memo, time, hit FROM board1 WHERE num=" + idx;
		ResultSet rs = stmt.executeQuery(sql);
		 if(rs.next()){ //단 한개의 게시물만 출력이 되므로 while이 아니라 if문을 씀
				String name = rs.getString(1);
				String title = rs.getString(2);
				String memo = rs.getString(3);
				String time = rs.getString(4);
				int hit = rs.getInt(5);
				hit++; //hit값을 1증가시킴 여기서 hit는 조회수를 의미하며 조회되자마자 1이 되야함
		
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
 <title>게시판</title>
 </head>
 <body>
<table>
  <tr>
   <td>
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
     <tr style="background:url('img/table_mid.gif') repeat-x; text-align:center;">
      <td width="5"><img src="img/table_left.gif" width="5" height="30" /></td>
      <td>내 용</td>
      <td width="5"><img src="img/table_right.gif" width="5" height="30" /></td>
     </tr>
    </table>
   <table width="413">
     <tr>
      <td width="0">&nbsp;</td>
      <td align="center" width="76">글번호</td>
      <td width="319"><%=idx%></td> <%--위에서 초기화한 변수값들을 출력시키는 부분 --%>
      <td width="0">&nbsp;</td>
     </tr>
	 <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
    <tr>
      <td width="0">&nbsp;</td>
      <td align="center" width="76">조회수</td>
      <td width="319"><%=hit%></td>
      <td width="0">&nbsp;</td>
     </tr>
	 <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
    <tr>
      <td width="0">&nbsp;</td>
      <td align="center" width="76">이름</td>
      <td width="319"><%=name%></td>
      <td width="0">&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
    <tr>
      <td width="0">&nbsp;</td>
      <td align="center" width="76">작성일</td>
      <td width="319"><%=time%></td>
      <td width="0">&nbsp;</td>
     </tr>
      <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
    <tr>
      <td width="0">&nbsp;</td>
      <td align="center" width="76">제목</td>
      <td width="319"><%=title%></td>
      <td width="0">&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
                <tr>
      <td width="0"></td>
                   <td width="399" colspan="2" height="200"><%=memo %>
                </tr>
                <% 
                //증가시킨 조회수 값을 데이터베이스에 넣기 위한 SQL문을 만들고 실행
 	sql = "UPDATE board1 SET hit=" + hit + " where num=" +idx; //증가한 hit,조회수 값을 수정하는 것이므로 UPDATE문을 사용한다.
 	stmt.executeUpdate(sql);
 	rs.close();
 	stmt.close();
 	conn.close();
	 	} 
	}catch(SQLException e) {
}

%>
     <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
     <tr height="1" bgcolor="#82B5DF"><td colspan="4" width="407"></td></tr>
     <tr align="center">
      <td width="0">&nbsp;</td>
      <td colspan="2" width="399"><input type=button value="글쓰기"  OnClick="window.location='write.jsp'">	
	<input type=button value="목록" OnClick="window.location='list.jsp'">	
	<input type=button value="수정" OnClick="window.location='modify.jsp?idx=<%=idx%>'">
	<input type=button value="삭제" OnClick="window.location='delete.jsp?idx=<%=idx%>'">
	<input type=button value="답글" OnClick="window.location='reply.jsp?idx=<%=idx%>'">
      <td width="0">&nbsp;</td>
     </tr>
    </table>
   </td>
  </tr>
 </table>
</body>

</html>

