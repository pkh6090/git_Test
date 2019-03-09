<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<% request.setCharacterEncoding("utf-8");%>

<% 
   String id = request.getParameter("id");
   String passwd= request.getParameter("passwd");
   String name = request.getParameter("name");   
   String comt = request.getParameter("comt");
   Timestamp register=new Timestamp(System.currentTimeMillis());

   Connection conn=null;
   PreparedStatement pstmt=null;
   String str="";
   try{
 	 String jdbcUrl="jdbc:mysql://192.168.25.44:3306/basicjsp";
     String dbId="jspid";
     String dbPass="jsppass";
 	 
 	 Class.forName("com.mysql.jdbc.Driver");
 	 conn=DriverManager.getConnection(jdbcUrl,dbId ,dbPass );
 	
 	 String sql= "insert into member2 values (?,?,?,?)";
 	 pstmt=conn.prepareStatement(sql);
 	 pstmt.setString(1,id);
     pstmt.setString(2,passwd);
 	 pstmt.setString(3,name); 
 	 pstmt.setString(4,comt);
 	 pstmt.executeUpdate();
 	 
 	 str= "member2 테이블에 새로운 레코드를 추가했습니다.";

 	}catch(Exception e){ 
 		e.printStackTrace();
 		str="member2 테이블에 새로운 레코드를 추가에 실패했습니다";
 	}finally{
 		if(pstmt != null) 
 			try{pstmt.close();}catch(SQLException sqle){}
 		if(conn != null) 
 			try{conn.close();}catch(SQLException sqle){}
 	}
 %>

<html>
<head>
<title>레코드 추가</title>
</head>
<body>
  <%=str %>
  <input type="button" value="목록으로" onClick="location.href='selectTest.jsp'">
</body>
</html>