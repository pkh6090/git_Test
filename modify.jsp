<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page import="java.sql.*"%> <%--SQL���� ����� ���� import --%>
<script language = "javascript">  // �ڹ� ��ũ��Ʈ ����

function modifyCheck()
  {
   var form = document.modifyform;
   
   if( !form.password.value )
   {
    alert( "��й�ȣ�� �����ּ���" );
    form.password.focus();
    return;
   }
   
  if( !form.title.value )
   {
    alert( "������ �����ּ���" );
    form.title.focus();
    return;
   }
 
  if( !form.memo.value )
   {
    alert( "������ �����ּ���" );
    form.memo.focus();
    return;
   }  
 		form.submit();
  } 
</script>
<%
	request.setCharacterEncoding("euc-kr");
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/basicjsp";
	String id = "jspid";
	String pass = "jsppass";
	
	String name = "";
	String password = "";
	String title = "";
	String memo = "";
	int idx = Integer.parseInt(request.getParameter("idx"));
	
	try {
		
		Connection conn = DriverManager.getConnection(url,id,pass);
		Statement stmt = conn.createStatement();
		
		String sql = "SELECT USERNAME, PASSWORD, TITLE, MEMO FROM board1 WHERE NUM=" + idx;
		ResultSet rs = stmt.executeQuery(sql);

		
		if(rs.next()){
			
			name = rs.getString(1);
			password = rs.getString(2);
			title = rs.getString(3);
			memo = rs.getString(4);
		}
		
		rs.close();
		stmt.close();
		conn.close();

	}catch(SQLException e) {
		out.println( e.toString() );
	}
	 
%>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
 <title>�Խ���</title>
 </head>
 <body>
<table>
<form name=modifyform method=post action="modify_ok.jsp?idx=<%=idx%>">
<%--���� �߰���Ŵ �Է��� ������ modify_ok.jsp�� �Ѿ--%> 
  <tr>
   <td>
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
     <tr style="background:url('img/table_mid.gif') repeat-x; text-align:center;">
      <td width="5"><img src="img/table_left.gif" width="5" height="30" /></td>
      <td>����</td>
      <td width="5"><img src="img/table_right.gif" width="5" height="30" /></td>
     </tr>
    </table>
   <table>
     <tr>
      <td>&nbsp;</td>
      <td align="center">����</td>
      <td><input type=text name=title size=50  maxlength=50 value="<%=title%>"></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
    <tr>
      <td>&nbsp;</td>
      <td align="center">�̸�</td>
      <td><%=name%><input type=hidden name=name size=50  maxlength=50 value="<%=name%>"></td>
      <%-- type=hidden���� �����ִµ� �Ķ���� ���� ������ �־ ����ڰ� ������ �� ���� ���Բ� �� --%>
      <td>&nbsp;</td>
     </tr>
      <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
    <tr>
      <td>&nbsp;</td>
      <td align="center">��й�ȣ</td>
      <td><input type=password name="password" id="pass" size=50  maxlength=50 ></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
     <tr>
      <td>&nbsp;</td>
      <td align="center">����</td>
      <td><textarea name=memo cols=50 rows=13><%=memo%></textarea></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
     <tr height="1" bgcolor="#82B5DF"><td colspan="4"></td></tr>
     <tr align="center">
      <td>&nbsp;</td>
      <td colspan="2"><input type="button" value="����" OnClick="javascript:modifyCheck();"> <%--���� ��ư Ŭ���� ���� �ִ� modifyCheck�Լ��� ���� --%>
      <input type=button value="���" OnClick="javascript:history.back(-1)"> <%--��� ��ư Ŭ���� �ش� ������ �ٷ� ������ �������� �̵��� --%>
      <td>&nbsp;</td>
     </tr> 
</table>
</body> 
</html>



