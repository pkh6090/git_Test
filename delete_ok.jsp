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
	int idx = Integer.parseInt(request.getParameter("idx")); //idx���� �޾ƿ�
	String passw = request.getParameter("password"); //delete.jsp���� �Է��� ��й�ȣ�� passw�� ������
	
	try{
				
		Connection conn = DriverManager.getConnection(url,id,pass);
		Statement stmt = conn.createStatement();
		
		String sql = "SELECT password FROM board1 WHERE num=" + idx; //select���� �̿��ؼ� �ش� ��ȣ�� �´� ��й�ȣ�� ã��
		ResultSet rs = stmt.executeQuery(sql);
		
		 if(rs.next()){
				password = rs.getString(1); //�����ͺ��̽����� �Է��� �н����忡 ��
		 }
		 
		 if(password.equals(passw)) { //delete.jsp���� �Է��� ��й�ȣ�� ���� ������� ����
			   			
			sql = "DELETE FROM board1 WHERE NUM=" + idx;	
			stmt.executeUpdate(sql);	 
%>
  			<script language=javascript>
   				self.window.alert("�ش� ���� �����Ͽ����ϴ�.");
   				location.href="list.jsp";
  			</script>

<%
		rs.close();
		stmt.close();
		conn.close();
		
		 } else { //��й�ȣ�� Ʋ���� ��� ����
%>
			<script language=javascript>
			 self.window.alert("��й�ȣ�� Ʋ�Ƚ��ϴ�.");
				location.href="javascript:history.back()";
			</script>
<%		
		 }
 	} catch(SQLException e) {
		out.println( e.toString() );
	} 
%>

