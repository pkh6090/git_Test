<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
<title>레코드 수정</title>
</head>
<body>
  <h2>member2 테이블의 레코드 수정</h2>
    
  <form method="post" action="updateTestPro.jsp" onsubmit="return formCheck()">
      아이디: <input type="text" name="id" maxlength="50"><br>
      패스워드: <input type="password" name="passwd" maxlength="16"><br>
      변경할 내용: <input type="text" name="comt" maxlength="10"><br>
      <input type="submit" value="입력완료">
  </form>
  <script>
	function formCheck() {
	    var id = document.forms[0].id.value;     
	     // 사용하기 쉽도록 변수를 선언하여 담아주고,
	    var passwd = document.forms[0].passwd.value;
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
	    if (comt == null || comt == "" ){
	        alert('내용을 입력하세요');   
	        document.forms[0].comt.focus();
	        return false;            
	    }
	}	
	</script>
</body>
</html>