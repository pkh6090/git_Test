<%@ page language="java" contentType="text/html; charset=EUC-KR"  pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>인터넷 게시판 만들기 </title>
</head>
<%
    int idx = 1; 
    String title = "제목입니다."; 
    String writer = "작성자이름"; 
    String regdate = "120610"; 
    int count = 10000; 
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