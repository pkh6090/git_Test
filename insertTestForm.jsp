<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>레코드 추가</title>
</head>
<body>
  <h2>member2테이블에 레코드 추가</h2>
    
  <form method="post" action="insertTestPro.jsp" onsubmit="return formCheck()">
      아이디: <input type="text" name="id" maxlength="50"><br>
      패스워드: <input type="password" name="passwd" maxlength="16"><br>
      이름: <input type="text" name="name" maxlength="10"><br>
      내용: <input type="text" name="comt" maxlength="50"><br>
      <input type="submit" value="입력완료">
  </form>
  <script>
	function formCheck() {
	    var id = document.forms[0].id.value;  
	    var passwd = document.forms[0].passwd.value;
	    var name = document.forms[0].name.value;	
	    var comt = document.forms[0].comt.value;
	     
	    if (id == null || id == ""){      // null인지 비교한 뒤
	        alert('아이디를 입력하세요');           // 경고창을 띄우고
	        document.forms[0].id.focus();    // 해당태그에 포커스를 준뒤
	        return false;                       // false를 리턴합니다.
	    }
	    if (passwd == null ||  passwd  == ""){   
	        alert('패스워드를 입력하세요'); 
	        document.forms[0].passwd.focus();            
	        return false;               
	    }    
	    if (name == null || name == "" ){
	        alert('이름을 입력하세요');   
	        document.forms[0].name.focus();
	        return false;            
	    }
	    if (comt == null || comt == "" ){
	        alert('이름을 입력하세요');   
	        document.forms[0].comt.focus();
	        return false;            
	    }
	}	
	</script>
</body>
</html>