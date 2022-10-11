<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//세션연결상태->바로 종료->메모리상의 데이터를 삭제
	session.invalidate();
%>
<script>
	alert("정상적으로 로그아웃되었습니다.");
	location.href="Login.jsp";//location.herf="경로포함해서 이동할페이지명"
</script>