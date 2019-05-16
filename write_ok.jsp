<%@ page language="java" contentType="text/html; charset=EUC-KR"

    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%><%--SQL문을 사용하기 위해 java.sql.*을 import --%>  
<%
	request.setCharacterEncoding("euc-kr"); //받아오는 값들을 한글로 인코딩을 해줌

	Class.forName("com.mysql.jdbc.Driver");
	
	String url = "jdbc:mysql://localhost:3306/basicjsp";
	String id = "jspid";
	String pass = "jsppass";
	String name = request.getParameter("name"); //write.jsp에서 각 항목에 입력한 데이터 값을 가져옴
	String password = request.getParameter("password");
	String title = request.getParameter("title");
	String memo = request.getParameter("memo");
	int max = 0; //max라는 변수 선언
	
	try {	
		Connection conn = DriverManager.getConnection(url,id,pass);		
		Statement stmt = conn.createStatement(); 
		String sql = "SELECT MAX(NUM) FROM board1"; 
		//select문으로 Num의 max값을 받아옴. 이유는 글번호는 현재의 제일 높은 번호보다 +1이 되어 만들어지기 때문에
		//자신의 글번호를 ref에 넣기 위함이다.
		ResultSet rs = stmt.executeQuery(sql); 
		if(rs.next()){ 
			max=rs.getInt(1); 
			} 				
		sql = "INSERT INTO board1(USERNAME,PASSWORD,TITLE,MEMO,REF) VALUES(?,?,?,?,?)"; //가져온 데이터로 테이블에 삽입을 해줌
		PreparedStatement pstmt = conn.prepareStatement(sql); //PreparedStatement을 사용 오류잡기가 더 편함
		
		pstmt.setString(1, name);
		pstmt.setString(2, password);
		pstmt.setString(3, title);
		pstmt.setString(4, memo);
		pstmt.setInt(5, max+1);
		
		pstmt.execute();
		pstmt.close();
		stmt.close();
		conn.close();
} catch(SQLException e) {
	out.println( e.toString() );
	}
%>
  <script language=javascript> //자바스크립트를 사용. 이 부분은 사용자가 페이지를 볼 필요가 없으므로 html파일이 필요가 없다.
   self.window.alert("입력한 글을 저장하였습니다."); //데이터 베이스에 자료가 입력이 되면 경고창을 뛰운뒤
   location.href="list.jsp"; //목록창으로 다시 이동하게 됨

</script>

