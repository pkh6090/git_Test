<%@ page language="java" contentType="text/html; charset=EUC-KR"

    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>  
<%
	request.setCharacterEncoding("euc-kr"); //받아오는 값들을 한글로 인코딩을 해줌

	Class.forName("com.mysql.jdbc.Driver");
	
	String url = "jdbc:mysql://192.168.25.44:3306/basicjsp";
	String id = "jspid";
	String pass = "jsppass";
	String name = request.getParameter("name"); //write.jsp에서 각 항목에 입력한 데이터 값을 가져옴
	String password = request.getParameter("password");
	String title = request.getParameter("title");
	String memo = request.getParameter("memo");
	
	try {	
		Connection conn = DriverManager.getConnection(url,id,pass);
		
		String sql = "INSERT INTO board1(username,password,title,memo) VALUES(?,?,?,?)"; //가져온 데이터로 테이블에 삽입을 해줌
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, name);
		pstmt.setString(2, password);
		pstmt.setString(3, title);
		pstmt.setString(4, memo);
		
		pstmt.execute();
		pstmt.close();
		
		conn.close();
} catch(SQLException e) {
	out.println( e.toString() );
	}
%>
  <script language=javascript>
   self.window.alert("입력한 글을 저장하였습니다."); //데이터 베이스에 자료가 입력이 되면 경고창을 뛰운뒤
   location.href="list.jsp"; //목록창으로 다시 이동하게 됨

</script>

