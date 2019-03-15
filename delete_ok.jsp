<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>  
			
<%
	request.setCharacterEncoding("euc-kr");

	Class.forName("com.mysql.jdbc.Driver");
	
	String url = "jdbc:mysql://192.168.25.44:3306/basicjsp";
	String id = "jspid";
	String pass = "jsppass";
	String password = null;
	int idx = Integer.parseInt(request.getParameter("idx")); //idx값을 받아옴
	String passw = request.getParameter("password"); //delete.jsp에서 입력한 비밀번호를 passw로 저장함
	
	try{
				
		Connection conn = DriverManager.getConnection(url,id,pass);
		Statement stmt = conn.createStatement();
		
		String sql = "SELECT password FROM board1 WHERE num=" + idx; //select문을 이용해서 해당 번호에 맞는 비밀번호를 찾음
		ResultSet rs = stmt.executeQuery(sql);
		
		 if(rs.next()){
				password = rs.getString(1); //데이터베이스에서 입력한 패스워드에 값
		 }
		 
		 if(password.equals(passw)) { //delete.jsp에서 입력한 비밀번호와 값이 같은경우 실행
			   			
			sql = "DELETE FROM board1 WHERE NUM=" + idx;	
			stmt.executeUpdate(sql);	 
%>
  			<script language=javascript>
   				self.window.alert("해당 글을 삭제하였습니다.");
   				location.href="list.jsp";
  			</script>

<%
		rs.close();
		stmt.close();
		conn.close();
		
		 } else { //비밀번호가 틀렸을 경우 실행
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

