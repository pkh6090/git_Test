<%@ page language="java" contentType="text/html; charset=EUC-KR"

    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>  
<%
	request.setCharacterEncoding("euc-kr"); //�޾ƿ��� ������ �ѱ۷� ���ڵ��� ����

	Class.forName("com.mysql.jdbc.Driver");
	
	String url = "jdbc:mysql://192.168.25.44:3306/basicjsp";
	String id = "jspid";
	String pass = "jsppass";
	String name = request.getParameter("name"); //write.jsp���� �� �׸� �Է��� ������ ���� ������
	String password = request.getParameter("password");
	String title = request.getParameter("title");
	String memo = request.getParameter("memo");
	
	try {	
		Connection conn = DriverManager.getConnection(url,id,pass);
		
		String sql = "INSERT INTO board1(username,password,title,memo) VALUES(?,?,?,?)"; //������ �����ͷ� ���̺� ������ ����
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
   self.window.alert("�Է��� ���� �����Ͽ����ϴ�."); //������ ���̽��� �ڷᰡ �Է��� �Ǹ� ���â�� �ٿ��
   location.href="list.jsp"; //���â���� �ٽ� �̵��ϰ� ��

</script>

