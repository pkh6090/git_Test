<%@page import="java.util.regex.Pattern"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"  pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>인터넷 게시판 만들기 </title>
</head>
<% 
	request.setCharacterEncoding("euc-kr");	

    int idx = 1; 
    String title = request.getParameter("title"); 
    String writer = request.getParameter("writer"); 
    String regdate = request.getParameter("regdate"); 
    int count = 10000; 
    String content = request.getParameter("content"); 

	if(title == "" ||title == null) out.println("title이 null입니다.");
 
	if(writer == "" ||writer == null)
    out.println("사용자 항목이 비어있습니다.");   
	else if(!Pattern.matches("^[_0-9a-zA-Z-]+@[0-9a-zA-Z-]+(.[_0-9a-zA-Z-]+)*$", writer))
    out.println("작성자 항목이 이메일 형식이 아닙니다.");
 
	if(regdate == "" ||regdate == null)
    out.println("날짜가 비어있습니다.");
	else if(!Pattern.matches("^[0-9]*$", regdate))
    out.println("날짜 항목이 숫자형식이 아닙니다.");
 
	if(content == "" ||content == null) out.println("content가 null입니다.");


%>


<body>
<h1>게시판 목록</h1>
	<table>		
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>날짜</th>
			<th>조회수</th>		
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
			<th>인터넷 게시판 만들기</th>
			<th>박경훈</th>
			<th>2019.02.26</th>
			<th>12</th>		
		</tr>
	</table>
	<a href="write.jsp">글쓰기</a>
</body>
</html>