<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
 <title>�Խ���</title>
 </head>
 <body>
 <%
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://192.168.25.44:3306/basicjsp";
	String id = "jspid";
	String pass = "jsppass";
	int total = 0;
	
	try {
		Connection conn = DriverManager.getConnection(url,id,pass); //db����
		Statement stmt = conn.createStatement(); //statementŸ���� ��ü ����

		String sqlCount = "SELECT COUNT(*) FROM board1"; //db���� �ڷ᰹���� ã����
		ResultSet rs = stmt.executeQuery(sqlCount); //�����ͺ��̽� ����
		
		if(rs.next()){ //ã�� ����� ������ true
			total = rs.getInt(1); //select���� ù ��° �ʵ� ���⼱ COUNT(*) 
		}
		rs.close();
		out.print("�� �Խù� : " + total + "��"); //�� �Խù� �� ���
		
		String sqlList = "SELECT num, username, title, time, hit from board1 order by NUM DESC"; //���̺� �ִ� ���� �������� ��������(desc) ����
		rs = stmt.executeQuery(sqlList); //�����ͺ��̽� ����
		
%>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr height="5"><td width="5"></td></tr>
 <tr>
   <td width="5"></td>
   <td width="73">��ȣ</td>
   <td width="379">����</td>
   <td width="73">�ۼ���</td>
   <td width="164">�ۼ���</td>
   <td width="58">��ȸ��</td>
   <td width="7"></td>
  </tr>
<%
	if(total==0) { //�Խù��� �ϳ��� ������� ���
%>
	 		<tr align="center" bgcolor="#FFFFFF" height="30">
	 	   <td colspan="6">��ϵ� ���� �����ϴ�.</td>
	 	  </tr>
<%
	 	} else {
	 		
		while(rs.next()) { //�Խù��� �ϳ��� ������� �ݺ��� while�� �ڷḦ ã��
			int idx = rs.getInt(1); //ù��° num���� idx��� ������ ���� 
			String name = rs.getString(2);//�̸�
			String title = rs.getString(3);//����
			String time = rs.getString(4);//�ð�
			int hit = rs.getInt(5);//��ȸ��
		
%>
<tr height="25" align="center">
	<td>&nbsp;</td>
	<td><%=idx %></td>
	<td align="left"><a href="view.jsp?idx=<%=idx%>"><%=title %></td> <!-- ���� ��ũ�� �Ŵ� �±׸� �Է� get����� ��� �ּҵڿ� ?�� ���ε� ������=�������� �����ϸ� �� ������ �ش��ּҿ� �Ƿ�����.  -->
	<td align="center"><%=name %></td>
	<td align="center"><%=time %></td>
	<td align="center"><%=hit %></td>
	<td>&nbsp;</td>
</tr>
  <tr height="1" bgcolor="#D2D2D2"><td colspan="6"></td></tr>
<% 
		}
	} 
	rs.close(); //���� ��ü�� ������
	stmt.close();
	conn.close();
} catch(SQLException e) {
	out.println( e.toString() ); //������ ������ �߻��� ����� ��
}
%>
 <tr height="1" bgcolor="#82B5DF"><td colspan="6" width="752"></td></tr>
 </table>
 
<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr><td colspan="4" height="5"></td></tr>
  <tr align="center">   
   <td><input type=button value="�۾���" OnClick="window.location='write.jsp'"></td> <!--�۾��� ��ư�� write.jsp�� ��ũ�� �ɾ��� -->
</tr>
</table>
</body> 
</html>

