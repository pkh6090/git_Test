<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date"%> <%--sql���� ����ϱ� ���ؼ� import��ŵ�ϴ�. --%>

<%
	final int ROWSIZE = 10; //���������� ���� �Խù��� �� ����
	final int BLOCK = 10; //�Ʒ��� ���� ������ �ִ� ���� 1~10/ 11~20������ 10�� ����

	int pg = 1; //�⺻ ������ ��
	
	if(request.getParameter("pg")!=null) { //�޾ƿ� pg���� ���� ��, �ٸ������� �϶�
		pg = Integer.parseInt(request.getParameter("pg")); //pg���� ����
	}
	
	int start = (pg*ROWSIZE) - (ROWSIZE-1); //�ش������������� ���۹�ȣ = 1	
	int end = (pg*ROWSIZE); //�ش������������� ����ȣ  = 10
	
	int allPage = 0; //��ü ������ ��
	
	int startPage = ((pg-1)/BLOCK*BLOCK)+1; //���ۺ�ϼ��� 1~10 =1, 11~20 =11 
	int endPage = ((pg-1)/BLOCK*BLOCK)+BLOCK; //����ϼ��� 1~10 =10, 11~20 =20

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
 <title>�Խ���</title>
 </head>
 <body>
 <%
 	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/basicjsp";
	String id = "jspid";
	String pass = "jsppass";
	int total = 0;
	
	try {
		Connection conn = DriverManager.getConnection(url,id,pass); //�����ͺ��̽� ����
		Statement stmt = conn.createStatement();//statementŸ���� ��ü����
		Statement stmt1 = conn.createStatement();//statement1Ÿ���� ��ü����
		String sql = "";

		String sqlCount = "SELECT COUNT(*) FROM board1"; //�����ͺ��̽����� �ڷᰳ���� ã�� SQL��
		ResultSet rs = stmt.executeQuery(sqlCount); //Result������ �����ͺ��̽� ����
		
		if(rs.next()){ //rs.next()�� ��ȯ���� true or false�Դϴ�. ���⼭ ã�� ����� ������ true
			total = rs.getInt(1); //SELECT���� ù��° �ʵ� ���⿡���� COUNT(*)
		}

		int sort=1;
		String sqlSort = "SELECT NUM from board1 order by ref desc, step asc";
		rs = stmt.executeQuery(sqlSort);
	
		
		while(rs.next()){
			int stepNum = rs.getInt(1);
			sql = "UPDATE board1 SET STEP2=" + sort + " where NUM=" +stepNum;
		 	stmt1.executeUpdate(sql);
		 	sort++;
		}
		
		allPage = (int)Math.ceil(total/(double)ROWSIZE);
		
		if(endPage > allPage) {
			endPage = allPage;
		}
		
		out.print("�� �Խù� : " + total + "��"); //�Խù��� ���
		
		String sqlList = "SELECT NUM, USERNAME, TITLE, TIME, HIT, INDENT from board1 where STEP2 >="+start + " and STEP2 <= "+ end +" order by step2 asc";
		//select���� indent�� �߰��˻��ϸ�, �������� Num, �۹�ȣ�� �̿��� �����̿����� ����� �߰��Ǿ����Ƿ�
		//�۹�ȣ ������ �ƴ� REF�� STEP�� �̿��� ������ �Ѵ�.
		rs = stmt.executeQuery(sqlList);//�����ͺ��̽� ����
		
%>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr height="5"><td width="5"></td></tr>
 <tr style="background:url('img/table_mid.gif') repeat-x; text-align:center;">
   <td width="5"><img src="img/table_left.gif" width="5" height="30" /></td>
   <td width="73">��ȣ</td>
   <td width="379">����</td>
   <td width="73">�ۼ���</td>
   <td width="164">�ۼ���</td>
   <td width="58">��ȸ��</td>
   <td width="7"><img src="img/table_right.gif" width="5" height="30" /></td>
  </tr>
<%
	if(total==0) { //total ��, �ƹ��� �ڷᰡ �ö���� ���� ��� �ش���� ���
%>
	 		<tr align="center" bgcolor="#FFFFFF" height="30">
	 	   <td colspan="6">��ϵ� ���� �����ϴ�.</td>
	 	  </tr>
<%
	 	} else { //total�� �ڷᰡ 1���̻� �ִٸ�
	 		
		while(rs.next()) { //�ݺ��� while�� �ڷḦ ã�´�. rs.next()�� ������������ Ŀ�� �̵�
			int idx = rs.getInt(1); //1�� ù��° �� num���� idx��� ������ ����
			String name = rs.getString(2); //name
			String title = rs.getString(3); //title
			String time = rs.getString(4); //time
			int hit = rs.getInt(5); //hit
			int indent = rs.getInt(6); //indent
			
			Date date = new Date();
			SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd"); //��, ��, �Ϸ� ��¥�� ǥ��
			String year = (String)simpleDate.format(date);
			String yea = time.substring(0,10);
		
%>
<tr height="25" align="center">
	<td>&nbsp;</td>
	<td><%=idx %></td>
	<td align="left">
	<% 
		
	for(int j=0;j<indent;j++){
%>		&nbsp;&nbsp;&nbsp;<%
	} //�鿩����
	if(indent!=0){
%>		<img src='img/reply_icon.gif' />
<%
	} //����̶�� �̹��� �߰�
%>
	<a href="view.jsp?idx=<%=idx%>&pg=<%=pg%>"><%=title %></a>
	<%--���� ��ũ�� �Ŵ� href�±� �Է� ��ũ�� �Ŵ� �ּҴ� view.jsp?idx=<%=idx%> GET����� ������� �ּҵڿ� ?�� ���ε� ������=�������� ���� ���ָ� �� ������ �ش� �ּҿ� �Ƿ���--%>
<%
	if(year.equals(yea)){ //���� �޺κп� ���ǹ��� �޾� �̹����� �߰���Ŵ
%>
			<img src='img/new.jpg' />
<%
		} 
%>
	</td>
	<td align="center"><%=name %></td>
	<td align="center"><%=yea %></td>
	<td align="center"><%=hit %></td>
	<td>&nbsp;</td>
</tr>
  <tr height="1" bgcolor="#D2D2D2"><td colspan="6"></td></tr>
<% 
		}
	} 
	rs.close(); //rs��ü ��ȯ
	stmt.close(); //stmt��ü ��ȯ
	conn.close(); //conn��ü ��ȯ
} catch(SQLException e) {
//	out.println( e.toString() ); //������ ����� �������
}
%>
 <tr height="1" bgcolor="#82B5DF"><td colspan="6" width="752"></td></tr>
 </table>
 
<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr><td colspan="4" height="5"></td></tr>
  <tr>
	<td align="center">
		<%
			if(pg>BLOCK) {
		%>
			[<a href="list.jsp?pg=1">����</a>]
			[<a href="list.jsp?pg=<%=startPage-1%>">��</a>]
		<%
			}
		%>
		
		<%
			for(int i=startPage; i<= endPage; i++){
				if(i==pg){
		%>
					<u><b>[<%=i %>]</b></u>
		<%
				}else{
		%>
					[<a href="list.jsp?pg=<%=i %>"><%=i %></a>]
		<%
				}
			}
		%>
		
		<%
			if(endPage<allPage){
		%>
			[<a href="list.jsp?pg=<%=endPage+1%>">��</a>]
			[<a href="list.jsp?pg=<%=allPage%>">����</a>]
		<%
			}
		%>
		</td>
		</tr>
		  <tr align="center">
   <td><input type=button value="�۾���" OnClick="window.location='write.jsp'"></td><%--OnClick�������� Ŭ������ �� write.jsp�� �Ѿ --%>
  </tr>
 </table>
 </body> 
</html>



