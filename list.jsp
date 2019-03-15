<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
 <title>게시판</title>
 </head>
 <body>
 <%
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://192.168.25.44:3306/basicjsp";
	String id = "jspid";
	String pass = "jsppass";
	int total = 0;
	
	try {
		Connection conn = DriverManager.getConnection(url,id,pass); //db연결
		Statement stmt = conn.createStatement(); //statement타입의 객체 생성

		String sqlCount = "SELECT COUNT(*) FROM board1"; //db내의 자료갯수를 찾아줌
		ResultSet rs = stmt.executeQuery(sqlCount); //데이터베이스 실행
		
		if(rs.next()){ //찾는 결과가 있으면 true
			total = rs.getInt(1); //select문의 첫 번째 필드 여기선 COUNT(*) 
		}
		rs.close();
		out.print("총 게시물 : " + total + "개"); //총 게시물 수 출력
		
		String sqlList = "SELECT num, username, title, time, hit from board1 order by NUM DESC"; //테이블에 있는 값을 가져오되 내림차순(desc) 정렬
		rs = stmt.executeQuery(sqlList); //데이터베이스 실행
		
%>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr height="5"><td width="5"></td></tr>
 <tr>
   <td width="5"></td>
   <td width="73">번호</td>
   <td width="379">제목</td>
   <td width="73">작성자</td>
   <td width="164">작성일</td>
   <td width="58">조회수</td>
   <td width="7"></td>
  </tr>
<%
	if(total==0) { //게시물이 하나고 없을경우 출력
%>
	 		<tr align="center" bgcolor="#FFFFFF" height="30">
	 	   <td colspan="6">등록된 글이 없습니다.</td>
	 	  </tr>
<%
	 	} else {
	 		
		while(rs.next()) { //게시물이 하나라도 있을경우 반복문 while로 자료를 찾음
			int idx = rs.getInt(1); //첫번째 num값을 idx라는 변수에 대입 
			String name = rs.getString(2);//이름
			String title = rs.getString(3);//제목
			String time = rs.getString(4);//시간
			int hit = rs.getInt(5);//조회수
		
%>
<tr height="25" align="center">
	<td>&nbsp;</td>
	<td><%=idx %></td>
	<td align="left"><a href="view.jsp?idx=<%=idx%>"><%=title %></td> <!-- 제목에 링크를 거는 태그를 입력 get방식을 사용 주소뒤에 ?를 붙인뒤 변수명=변수값을 설정하면 그 정보가 해당주소에 실려간다.  -->
	<td align="center"><%=name %></td>
	<td align="center"><%=time %></td>
	<td align="center"><%=hit %></td>
	<td>&nbsp;</td>
</tr>
  <tr height="1" bgcolor="#D2D2D2"><td colspan="6"></td></tr>
<% 
		}
	} 
	rs.close(); //각각 객체를 반한함
	stmt.close();
	conn.close();
} catch(SQLException e) {
	out.println( e.toString() ); //구동시 에러가 발생시 출력을 함
}
%>
 <tr height="1" bgcolor="#82B5DF"><td colspan="6" width="752"></td></tr>
 </table>
 
<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr><td colspan="4" height="5"></td></tr>
  <tr align="center">   
   <td><input type=button value="글쓰기" OnClick="window.location='write.jsp'"></td> <!--글쓰기 버튼을 write.jsp로 링크를 걸어줌 -->
</tr>
</table>
</body> 
</html>

