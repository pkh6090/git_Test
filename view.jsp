<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/basicjsp";
	String id = "jspid";
	String pass = "jsppass";
	int idx = Integer.parseInt(request.getParameter("idx")); //�Ѿ���� ������Ÿ���� �׻� string�̹Ƿ� �����͸� ��ȯ���־�� �Ѵ�.
	//������ view.jsp���� get������� idx���� �������� ����ϸ� �� ������ getParameter("idx") �̰��� �� ���̸� �� ���� idx�� �־���.
	//������ post�� get����̵� �Ѿ���� �Ǹ� ������Ÿ���� String�� �ǹǷ� ����ȯ���� int������ ��ȯ�ϴ� integer.parseint�� ����Ѵ�.
	try {
		
		Connection conn = DriverManager.getConnection(url,id,pass);
		Statement stmt = conn.createStatement();
		
		String sql = "SELECT username, title, memo, time, hit FROM board1 WHERE num=" + idx;
		ResultSet rs = stmt.executeQuery(sql);
		 if(rs.next()){ //�� �Ѱ��� �Խù��� ����� �ǹǷ� while�� �ƴ϶� if���� ��
				String name = rs.getString(1);
				String title = rs.getString(2);
				String memo = rs.getString(3);
				String time = rs.getString(4);
				int hit = rs.getInt(5);
				hit++; //hit���� 1������Ŵ ���⼭ hit�� ��ȸ���� �ǹ��ϸ� ��ȸ���ڸ��� 1�� �Ǿ���
		
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
 <title>�Խ���</title>
 </head>
 <body>
<table>
  <tr>
   <td>
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
     <tr style="background:url('img/table_mid.gif') repeat-x; text-align:center;">
      <td width="5"><img src="img/table_left.gif" width="5" height="30" /></td>
      <td>�� ��</td>
      <td width="5"><img src="img/table_right.gif" width="5" height="30" /></td>
     </tr>
    </table>
   <table width="413">
     <tr>
      <td width="0">&nbsp;</td>
      <td align="center" width="76">�۹�ȣ</td>
      <td width="319"><%=idx%></td> <%--������ �ʱ�ȭ�� ���������� ��½�Ű�� �κ� --%>
      <td width="0">&nbsp;</td>
     </tr>
	 <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
    <tr>
      <td width="0">&nbsp;</td>
      <td align="center" width="76">��ȸ��</td>
      <td width="319"><%=hit%></td>
      <td width="0">&nbsp;</td>
     </tr>
	 <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
    <tr>
      <td width="0">&nbsp;</td>
      <td align="center" width="76">�̸�</td>
      <td width="319"><%=name%></td>
      <td width="0">&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
    <tr>
      <td width="0">&nbsp;</td>
      <td align="center" width="76">�ۼ���</td>
      <td width="319"><%=time%></td>
      <td width="0">&nbsp;</td>
     </tr>
      <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
    <tr>
      <td width="0">&nbsp;</td>
      <td align="center" width="76">����</td>
      <td width="319"><%=title%></td>
      <td width="0">&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
                <tr>
      <td width="0"></td>
                   <td width="399" colspan="2" height="200"><%=memo %>
                </tr>
                <% 
                //������Ų ��ȸ�� ���� �����ͺ��̽��� �ֱ� ���� SQL���� ����� ����
 	sql = "UPDATE board1 SET hit=" + hit + " where num=" +idx; //������ hit,��ȸ�� ���� �����ϴ� ���̹Ƿ� UPDATE���� ����Ѵ�.
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
      <td colspan="2" width="399"><input type=button value="�۾���"  OnClick="window.location='write.jsp'">	
	<input type=button value="���" OnClick="window.location='list.jsp'">	
	<input type=button value="����" OnClick="window.location='modify.jsp?idx=<%=idx%>'">
	<input type=button value="����" OnClick="window.location='delete.jsp?idx=<%=idx%>'">
	<input type=button value="���" OnClick="window.location='reply.jsp?idx=<%=idx%>'">
      <td width="0">&nbsp;</td>
     </tr>
    </table>
   </td>
  </tr>
 </table>
</body>

</html>

