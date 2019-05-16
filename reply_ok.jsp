<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%> <%--SQL문을 사용하기 위한 import --%>
<%
//ref = 부모의 글번호를 저장하는 필드
//indent = 원글의 답글인지 답글의 답글인지를 구분하기 위한 들여쓰기
//step = 답글끼리의 출력순서를 위한 필드

	request.setCharacterEncoding("euc-kr");

	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/basicjsp";
	String id = "jspid";
	String pass = "jsppass";
	
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	String title = request.getParameter("title");
	String memo = request.getParameter("memo");
	int idx = Integer.parseInt(request.getParameter("idx"));
	
	try {
		int ref = 0;
		int indent = 0;
		int step = 0;

		Connection conn = DriverManager.getConnection(url,id,pass);
		Statement stmt = conn.createStatement();
		
		String sql = "SELECT REF, INDENT, STEP FROM board1 WHERE NUM=" + idx; 
		//select문을 이용해서 idx 즉 원글의 ref, indent, step의 값을 가져옵니다.
		ResultSet rs = stmt.executeQuery(sql);
		
		if(rs.next()) {
			ref = rs.getInt(1);
			indent = rs.getInt(2);
			step = rs.getInt(3);
		}
		
		sql = "UPDATE board1 SET STEP=STEP+1 where REF="+ref+" and STEP>" +step;
		stmt.executeUpdate(sql);
		//Update문을 이용해서 ref값은 불러온 ref와 같고 step은 불러온 step값보다 큰 자료들의 step값보다 큰 자료들의 step을 +1시킴ㄴ
		
		sql = "INSERT INTO board1(USERNAME, PASSWORD, TITLE, MEMO, REF, INDENT, STEP) "+
				"values(?,?,?,?,?,?,?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, password);
		pstmt.setString(3, title);
		pstmt.setString(4, memo);
		pstmt.setInt(5, ref);
		pstmt.setInt(6, indent+1);
		pstmt.setInt(7, step+1);
		
		pstmt.execute(); 
		rs.close();
		stmt.close();
		pstmt.close();
		conn.close();
		
	}catch(Exception e) {
		
	}
	//insert문을 이용해서 데이터베이스에 자료를 입력한다.
	//reply.jsp에서 가져온 값들과 select문을 이용한 값들을 넣어주되 ref는(원글 번호)는 같은 값을 넣고 들여쓰기와 출력순서는 원글의 값보다 +1 시켜서 넣게된다.
%>
  <script language=javascript>
   self.window.alert("입력한 글을 저장하였습니다.");
   location.href="list.jsp";
   //입력이 완료되면 목로으로 돌아감
  </script>
