<%@ page language="java" contentType="text/html; charset=EUC-KR"  pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>���ͳ� �Խ��� ����� </title>
</head>
<%
    int idx = 1; 
    String title = "�����Դϴ�."; 
    String writer = "�ۼ����̸�"; 
    String regdate = "120610"; 
    int count = 10000; 
%>
<body>
<h1>�Խ��� ���</h1>
	<table>		
		<tr>
			<th>��ȣ</th>
			<th>����</th>
			<th>�ۼ���</th>
			<th>��¥</th>
			<th>��ȸ��</th>		
		</tr>	
		<tr>
    		<td><%=idx %></td>                 
     		<td><%=title %></td>
       		<td><%=writer %></td>
       		<td><%=regdate %></td>
       		<td><%=count %></td>   
		</tr>
		<tr>
			<th>1</th>
			<th>���ͳ� �Խ��� �����</th>
			<th>�ڰ���</th>
			<th>2019.02.26</th>
			<th>12</th>		
		</tr>
	</table>
	<a href="write.jsp">�۾���</a>
</body>
</html>