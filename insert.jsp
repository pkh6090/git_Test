<%@page import="java.util.regex.Pattern"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"  pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here </title>
</head>
<% 	
    String title = request.getParameter("title"); 
    String writer = request.getParameter("writer"); 
    String regdate = request.getParameter("regdate");     
    String content = request.getParameter("content"); 

	if(title == "" ||title == null) out.println("title�� null�Դϴ�.");
 
	if(writer == "" ||writer == null) out.println("����� �׸��� ����ֽ��ϴ�.");   
	else if(!Pattern.matches("^[_0-9a-zA-Z-]+@[0-9a-zA-Z-]+(.[_0-9a-zA-Z-]+)*$", writer)) out.println("�ۼ��� �׸��� �̸��� ������ �ƴմϴ�.");
 
	if(regdate == "" ||regdate == null) out.println("��¥�� ����ֽ��ϴ�.");
	else if(!Pattern.matches("^[0-9]*$", regdate)) out.println("��¥ �׸��� ���������� �ƴմϴ�.");
 
	if(content == "" ||content == null) out.println("content�� null�Դϴ�.");

	
	try {		 
	     String driverName = "oracle.jdbc.driver.OracleDriver"; //�����ͺ��̽��� �����ϱ����� ����̹��� �ε��մϴ�.	 
	     String url = "jdbc:oracle:thin:@localhost:1521:XE";            //���� URL������ ��Ʈ��ȣ(oracle��Ʈ), sid(oracle����)	 	 
	     Class.forName(driverName);
	     Connection con = DriverManager.getConnection(url,"board","ekzmskdlxm13");    // getCo... : �������� url, id, pw
	     out.println("Oracle �����ͺ��̽� db�� ���������� �����߽��ϴ�");
	     con.close();
	 
	} catch (Exception e) {	 
	     out.println("Oracle �����ͺ��̽� db ���ӿ� ������ �ֽ��ϴ�. <hr>");	 
	     out.println(e.getMessage());
	     e.printStackTrace();	 
	}	
%>
<body>
</body>
</html>