<%@ page language="java" contentType="text/html; charset=EUC-KR"

    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%><%--SQL���� ����ϱ� ���� java.sql.*�� import --%>  
<%
	request.setCharacterEncoding("euc-kr"); //�޾ƿ��� ������ �ѱ۷� ���ڵ��� ����

	Class.forName("com.mysql.jdbc.Driver");
	
	String url = "jdbc:mysql://localhost:3306/basicjsp";
	String id = "jspid";
	String pass = "jsppass";
	String name = request.getParameter("name"); //write.jsp���� �� �׸� �Է��� ������ ���� ������
	String password = request.getParameter("password");
	String title = request.getParameter("title");
	String memo = request.getParameter("memo");
	int max = 0; //max��� ���� ����
	
	try {	
		Connection conn = DriverManager.getConnection(url,id,pass);		
		Statement stmt = conn.createStatement(); 
		String sql = "SELECT MAX(NUM) FROM board1"; 
		//select������ Num�� max���� �޾ƿ�. ������ �۹�ȣ�� ������ ���� ���� ��ȣ���� +1�� �Ǿ� ��������� ������
		//�ڽ��� �۹�ȣ�� ref�� �ֱ� �����̴�.
		ResultSet rs = stmt.executeQuery(sql); 
		if(rs.next()){ 
			max=rs.getInt(1); 
			} 				
		sql = "INSERT INTO board1(USERNAME,PASSWORD,TITLE,MEMO,REF) VALUES(?,?,?,?,?)"; //������ �����ͷ� ���̺� ������ ����
		PreparedStatement pstmt = conn.prepareStatement(sql); //PreparedStatement�� ��� ������Ⱑ �� ����
		
		pstmt.setString(1, name);
		pstmt.setString(2, password);
		pstmt.setString(3, title);
		pstmt.setString(4, memo);
		pstmt.setInt(5, max+1);
		
		pstmt.execute();
		pstmt.close();
		stmt.close();
		conn.close();
} catch(SQLException e) {
	out.println( e.toString() );
	}
%>
  <script language=javascript> //�ڹٽ�ũ��Ʈ�� ���. �� �κ��� ����ڰ� �������� �� �ʿ䰡 �����Ƿ� html������ �ʿ䰡 ����.
   self.window.alert("�Է��� ���� �����Ͽ����ϴ�."); //������ ���̽��� �ڷᰡ �Է��� �Ǹ� ���â�� �ٿ��
   location.href="list.jsp"; //���â���� �ٽ� �̵��ϰ� ��

</script>

