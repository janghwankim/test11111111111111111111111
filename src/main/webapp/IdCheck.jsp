<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="hewon.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="UTF-8">
<title>중복 ID 체크</title>
</head>
<body bgcolor="#FFFFCC">
<br>
 <%
    //searchWord.js(idCheck(id)->IdCheck.jsp?mem_id='nup')
    //xhr객체 받을 xml형태로 받을 수 있도록 text/xml형태로 전환(태그+문자열)
    response.setContentType("text/xml;charset=utf-8");
 	String outString="";//xhr객체에게 전달할 내용을 담을변수를 선언
 	
    String mem_id=request.getParameter("mem_id");//null
    System.out.println("IdCheck.jsp의 mem_id=>"+mem_id);
    MemberDAO memMgr=new MemberDAO();
    boolean check=memMgr.checkId(mem_id);
    
    if(check==true){//이미 사용중인 아이디가 있다면
    	outString="<font color='red'><b>이미 사용중인 아이디</b></font>";
    }else{//사용X
    	outString="<font color='blue'><b>사용가능한 아이디</b></font>";
    }
    //xhr객체가 받을 수 있도록 전송
    out.println(outString);
    System.out.println(outString);//콘솔에 출력
    %>

</body>
</html>