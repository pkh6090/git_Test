<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>

<html>
<head>
<title>레코드  표시</title>
</head>
<body>
  <h2>member2 테이블의 레코드 표시</h2>
  <table border="1">
  <tr>
  	<td width="100">아이디</td>
  	<td width="100">패스워드</td>
  	<td width="100">이름</td>
  	<td width="200">내용</td>
  </tr>
  <input type="button" value="삽입" onClick="location.href='insertTestForm.jsp'">
  <input type="button" value="수정" onClick="location.href='updateTestForm.jsp'">
  <input type="button" value="삭제" onClick="location.href='deleteTestForm.jsp'">

<%
  Connection conn=null;
  PreparedStatement pstmt=null;
  ResultSet rs=null;

  try{
	 String jdbcUrl="jdbc:mysql://192.168.25.44:3306/basicjsp";
     String dbId="jspid";
     String dbPass="jsppass";
	 
	 Class.forName("com.mysql.jdbc.Driver");
	 conn=DriverManager.getConnection(jdbcUrl,dbId ,dbPass );

	 String sql= "select * from member2";
	 pstmt=conn.prepareStatement(sql);
	 rs=pstmt.executeQuery();

	 while(rs.next()){
	   String id= rs.getString("id");
       String passwd= rs.getString("passwd");
       String name= rs.getString("name"); 
       String comt= rs.getString("comt");
%>
       <tr>
  	     <td width="100"><%=id%></td>
  	     <td width="100"><%=passwd%></td>
  	     <td width="100"><%=name%></td>  
  	     <td width="200"><%=comt%></td>	     
       </tr>
<%  } 
  }catch(Exception e){ 
	 e.printStackTrace();
  }finally{
	 if(rs != null) 
	    try{rs.close();}catch(SQLException sqle){}
	 if(pstmt != null) 
		try{pstmt.close();}catch(SQLException sqle){}
	 if(conn != null) 
		try{conn.close();}catch(SQLException sqle){}
  }
%>
  </table>
</body>
</html>