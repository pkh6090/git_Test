<%@ page language="java" contentType="text/html; charset=EUC-KR"  pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>인터넷 게시판 만들기 - 게시판 입력창 </title>
</head>
<body>
	<form action="insert.jsp" method="post" onsubmit="return formCheck();">
		제목 : <input type="text" name="title"/><br/>
		작성자 : <input type="text" name="writer"/><br/>
		내용 : <textarea rows="10" cols="20" name="content"></textarea><br>
		날짜 : <input type="text" name="regdate"/><br/>
		<input type="submit" value="제출"/>
	</form>	     
	<script>
	function formCheck() {
		var title = document.forms[0].title.value;    	     
		var writer = document.forms[0].writer.value;
		var content = document.forms[0].content.value;    	     
		var regdate = document.forms[0].regdate.value;
				
	    if (title == null || title == ""){      
	        alert('제목을 입력하세요');           
	        document.forms[0].title.focus();    
	        return false;                      
	        }
	    if (writer == null || writer == ""){      
	        alert('작성자를 입력하세요');           
	        document.forms[0].writer.focus();    
	        return false;                      
	        } 
	    	    
	    if (content == null ||  content == ""){
	        alert('내용을 입력하세요'); 
	        document.forms[0].content.focus();
	        return false;
	    }	     
	    if (regdate == null || regdate == "" ){
	        alert('날짜를 입력하세요');   
	        document.forms[0].regdate.focus();
	        return false;            
	    }	
	}
		
	</script>
</body>
</html>