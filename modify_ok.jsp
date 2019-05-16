<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%> <%--SQL문을 사용하기 위한 import --%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
			
<%
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/basicjsp";
	String id = "jspid";
	String pass = "jsppass";
	String password = "";	
	
		try{			
			request.setCharacterEncoding("euc-kr");
			int idx = Integer.parseInt(request.getParameter("idx"));
			String title = request.getParameter("title");
			String memo = request.getParameter("memo");
			String passw = request.getParameter("password");
		
			Connection conn = DriverManager.getConnection(url,id,pass);
			Statement stmt = conn.createStatement();
		
			String sql = "SELECT password FROM board1 WHERE num=" + idx; //select문으로 비밀번호를 가져옴
			ResultSet rs = stmt.executeQuery(sql);
		
		 if(rs.next()){
				password = rs.getString(1);
		 } //modify에서 가져온 비밀번호를 저장함
		
		 if(password.equals(passw)) {
				sql = "UPDATE board1 SET title='" + title+ "' ,memo='"+ memo +"' WHERE num=" + idx;				
				stmt.executeUpdate(sql);				
%>
				  <script language=javascript>
				  	self.window.alert("글이 수정되었습니다.");
				  	location.href="view.jsp?idx=<%=idx%>";
				  </script>
<%
			rs.close();
			stmt.close();
			conn.close();
			
		} else {
%>
			<script language=javascript>
				self.window.alert("비밀번호를 틀렸습니다.");
				location.href="javascript:history.back()";
			</script>
<%			
		}		 
 } catch(SQLException e) {
	out.println( e.toString() );
} 

%>
