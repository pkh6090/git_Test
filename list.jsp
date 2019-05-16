<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date"%> <%--sql문을 사용하기 위해서 import시킵니다. --%>

<%
	final int ROWSIZE = 10; //한페이지에 보일 게시물의 총 갯수
	final int BLOCK = 10; //아래에 보일 페이지 최대 갯수 1~10/ 11~20식으로 10개 고정

	int pg = 1; //기본 페이지 값
	
	if(request.getParameter("pg")!=null) { //받아온 pg값이 있을 때, 다른페이지 일때
		pg = Integer.parseInt(request.getParameter("pg")); //pg값을 저장
	}
	
	int start = (pg*ROWSIZE) - (ROWSIZE-1); //해당페이지에서의 시작번호 = 1	
	int end = (pg*ROWSIZE); //해당페이지에서의 끝번호  = 10
	
	int allPage = 0; //전체 페이지 수
	
	int startPage = ((pg-1)/BLOCK*BLOCK)+1; //시작블록숫자 1~10 =1, 11~20 =11 
	int endPage = ((pg-1)/BLOCK*BLOCK)+BLOCK; //끝블록숫자 1~10 =10, 11~20 =20

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
 <title>게시판</title>
 </head>
 <body>
 <%
 	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/basicjsp";
	String id = "jspid";
	String pass = "jsppass";
	int total = 0;
	
	try {
		Connection conn = DriverManager.getConnection(url,id,pass); //데이터베이스 연결
		Statement stmt = conn.createStatement();//statement타입의 객체생성
		Statement stmt1 = conn.createStatement();//statement1타입의 객체생성
		String sql = "";

		String sqlCount = "SELECT COUNT(*) FROM board1"; //데이터베이스내의 자료개수를 찾는 SQL문
		ResultSet rs = stmt.executeQuery(sqlCount); //Result문으로 데이터베이스 실행
		
		if(rs.next()){ //rs.next()의 반환값은 true or false입니다. 여기서 찾는 결과가 있으면 true
			total = rs.getInt(1); //SELECT문의 첫번째 필드 여기에서는 COUNT(*)
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
		
		out.print("총 게시물 : " + total + "개"); //게시물수 출력
		
		String sqlList = "SELECT NUM, USERNAME, TITLE, TIME, HIT, INDENT from board1 where STEP2 >="+start + " and STEP2 <= "+ end +" order by step2 asc";
		//select문의 indent를 추가검색하며, 기존에는 Num, 글번호를 이용한 정렬이였지만 답글이 추가되었으므로
		//글번호 정렬이 아닌 REF와 STEP를 이용한 정렬을 한다.
		rs = stmt.executeQuery(sqlList);//데이터베이스 실행
		
%>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr height="5"><td width="5"></td></tr>
 <tr style="background:url('img/table_mid.gif') repeat-x; text-align:center;">
   <td width="5"><img src="img/table_left.gif" width="5" height="30" /></td>
   <td width="73">번호</td>
   <td width="379">제목</td>
   <td width="73">작성자</td>
   <td width="164">작성일</td>
   <td width="58">조회수</td>
   <td width="7"><img src="img/table_right.gif" width="5" height="30" /></td>
  </tr>
<%
	if(total==0) { //total 즉, 아무런 자료가 올라오지 않을 경우 해당글을 출력
%>
	 		<tr align="center" bgcolor="#FFFFFF" height="30">
	 	   <td colspan="6">등록된 글이 없습니다.</td>
	 	  </tr>
<%
	 	} else { //total에 자료가 1개이상 있다면
	 		
		while(rs.next()) { //반복문 while로 자료를 찾는다. rs.next()는 다음라인으로 커서 이동
			int idx = rs.getInt(1); //1은 첫번째 즉 num값을 idx라는 변수에 대입
			String name = rs.getString(2); //name
			String title = rs.getString(3); //title
			String time = rs.getString(4); //time
			int hit = rs.getInt(5); //hit
			int indent = rs.getInt(6); //indent
			
			Date date = new Date();
			SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd"); //년, 월, 일로 날짜를 표시
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
	} //들여쓰기
	if(indent!=0){
%>		<img src='img/reply_icon.gif' />
<%
	} //답글이라는 이미지 추가
%>
	<a href="view.jsp?idx=<%=idx%>&pg=<%=pg%>"><%=title %></a>
	<%--제목에 링크를 거는 href태그 입력 링크를 거는 주소는 view.jsp?idx=<%=idx%> GET방식의 방법으로 주소뒤에 ?를 붙인뒤 변수명=변수값을 같이 써주면 그 정보가 해당 주소에 실려감--%>
<%
	if(year.equals(yea)){ //제목 뒷부분에 조건문을 달아 이미지를 추가시킴
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
	rs.close(); //rs객체 반환
	stmt.close(); //stmt객체 반환
	conn.close(); //conn객체 반환
} catch(SQLException e) {
//	out.println( e.toString() ); //에러가 날경우 에러출력
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
			[<a href="list.jsp?pg=1">◀◀</a>]
			[<a href="list.jsp?pg=<%=startPage-1%>">◀</a>]
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
			[<a href="list.jsp?pg=<%=endPage+1%>">▶</a>]
			[<a href="list.jsp?pg=<%=allPage%>">▶▶</a>]
		<%
			}
		%>
		</td>
		</tr>
		  <tr align="center">
   <td><input type=button value="글쓰기" OnClick="window.location='write.jsp'"></td><%--OnClick구문으로 클릭했을 때 write.jsp로 넘어감 --%>
  </tr>
 </table>
 </body> 
</html>



