<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%> <%--SQL���� ����ϱ� ���� import --%>
<%
//ref = �θ��� �۹�ȣ�� �����ϴ� �ʵ�
//indent = ������ ������� ����� ��������� �����ϱ� ���� �鿩����
//step = ��۳����� ��¼����� ���� �ʵ�

	request.setCharacterEncoding("euc-kr");

	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/basicjsp";
	String id = "jspid";
	String pass = "jsppass";
	
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	String title = request.getParameter("title");
	String memo = request.getParameter("memo");
	int idx = Integer.parseInt(request.getParameter("idx"));
	
	try {
		int ref = 0;
		int indent = 0;
		int step = 0;

		Connection conn = DriverManager.getConnection(url,id,pass);
		Statement stmt = conn.createStatement();
		
		String sql = "SELECT REF, INDENT, STEP FROM board1 WHERE NUM=" + idx; 
		//select���� �̿��ؼ� idx �� ������ ref, indent, step�� ���� �����ɴϴ�.
		ResultSet rs = stmt.executeQuery(sql);
		
		if(rs.next()) {
			ref = rs.getInt(1);
			indent = rs.getInt(2);
			step = rs.getInt(3);
		}
		
		sql = "UPDATE board1 SET STEP=STEP+1 where REF="+ref+" and STEP>" +step;
		stmt.executeUpdate(sql);
		//Update���� �̿��ؼ� ref���� �ҷ��� ref�� ���� step�� �ҷ��� step������ ū �ڷ���� step������ ū �ڷ���� step�� +1��Ŵ��
		
		sql = "INSERT INTO board1(USERNAME, PASSWORD, TITLE, MEMO, REF, INDENT, STEP) "+
				"values(?,?,?,?,?,?,?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, password);
		pstmt.setString(3, title);
		pstmt.setString(4, memo);
		pstmt.setInt(5, ref);
		pstmt.setInt(6, indent+1);
		pstmt.setInt(7, step+1);
		
		pstmt.execute(); 
		rs.close();
		stmt.close();
		pstmt.close();
		conn.close();
		
	}catch(Exception e) {
		
	}
	//insert���� �̿��ؼ� �����ͺ��̽��� �ڷḦ �Է��Ѵ�.
	//reply.jsp���� ������ ����� select���� �̿��� ������ �־��ֵ� ref��(���� ��ȣ)�� ���� ���� �ְ� �鿩����� ��¼����� ������ ������ +1 ���Ѽ� �ְԵȴ�.
%>
  <script language=javascript>
   self.window.alert("�Է��� ���� �����Ͽ����ϴ�.");
   location.href="list.jsp";
   //�Է��� �Ϸ�Ǹ� ������� ���ư�
  </script>
