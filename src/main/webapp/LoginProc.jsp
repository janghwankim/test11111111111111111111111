<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="memMgr" class="hewon.MemberDAO" />
<%
	//Login.jsp->LoginProc.jsp->LoginSuccess.jsp
	String mem_id=request.getParameter("mem_id");
	String mem_passwd=request.getParameter("mem_passwd");
	System.out.println
		("mem_id=>"+mem_id+",mem_passwd=>"+mem_passwd);
	//MemberDAO객체필요->loginCheck()호출
	//MemberDAO memMgr=new MemberDAO();
	boolean check=memMgr.loginCheck(mem_id, mem_passwd);
	
%>
<%
	//check->LoginSuccess.jsp(인증화면), LogError.jsp(에러페이지)
	if(check){//if(check==true)인증성공
		session.setAttribute("idKey",mem_id);
		//response.sendRedirect("LoginSuccess.jsp");//단순페이지이동
		response.sendRedirect("Login.jsp");
	}else{
		response.sendRedirect("LogError.jsp");
	}
%>