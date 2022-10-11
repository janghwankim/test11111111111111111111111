<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="hewon.*,java.util.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<%!
    int pageSize=10;//numPerPage=>페이지당 보여주는 게시물수 10
    int blockSize=10;//pagePerBlock=>블럭당 보여준느 페이지수 10
    //회원가입 날짜 필드가 있을때 사용할것.
    SimpleDateFormat sdf=
                  new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<%
 //게시판을 맨 처음 실행시키면 무조건 1페이지부터 출력->가장 최근의 글부터
 String pageNum=request.getParameter("pageNum");
 if(pageNum==null){
	 pageNum="1";//default(무조건 처음에는 1페이지부터)
 }
 //"1"->1(nowPage)->현재 페이지
 int currentPage=Integer.parseInt(pageNum);
 //                 (1-1)*10+1=1,(2-1)*10+1=11,(3-1)*10+1=21
 int startRow=(currentPage-1)*pageSize+1;//시작 레코드번호
 int endRow=currentPage*pageSize;//1*10=10,2*10=20,3*10=30
 
 int count=0;//총레코드수
 int number=0;//beginPerPage(페이지별로 맨처음에 나오는 게시물번호)
 List<MemberDTO> memberList=null;//화면에 출력할 레코드를 저장할변수
 
 MemberDAO mem=new MemberDAO();
 count=mem.getMemberCount();//select count(*) from board;
 System.out.println("현재 레코드수(count)=>"+count);
 if(count > 0){                     //첫번째레코드번호, 불러올갯수
	 memberList=mem.getMembers(startRow, pageSize);
     System.out.println("MemberList.jsp의 memberList=>"+memberList);//null
 }
 //            122-(1-1)*10=122-0=122,121,120,119,,,
 //            122-(2-1)*10=122-10=112,111,110,,,
 number=count-(currentPage-1)*pageSize;
 System.out.println("페이지별로 number=>"+number);
 
%>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#e0ffff">
<center><b>글목록(전체 글:<%=count%>)</b>
<table width="700">
<tr>
    <td align="right" bgcolor="#b0e0e6">
    <a href="writeForm.jsp">글쓰기</a>
    </td>
</tr>
</table>
<!-- 데이터의 유무 -->
<%
  if(count==0){
%>
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
   <tr>
      <td align="center">회원에 저장된 글이 없습니다.</td>
   </tr>
</table>
<% }else { %>
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
    <tr height="30" bgcolor="#b0e0e6"> 
      <td align="center"  width="50"  >번호</td> 
      <td align="center"  width="150" >이름</td> 
      <td align="center"  width="150" >전화번호</td>
      <td align="center"  width="200" >주소</td> 
      <td align="center"  width="50" >이메일</td> 
      <td align="center"  width="100" >직업</td>    
    </tr>
    <!-- 실질적으로 레코드를 출력시켜주는 부분 -->
    <%
        for(int i=0;i<memberList.size();i++){
          MemberDTO member=memberList.get(i);//articleList.elementAt(i)
    %>
    
   <tr height="30"><!-- 하나씩 감소하면서 출력하는 게시물번호 -->
    <td align="center"  width="50" ><%=number-- %></td>
    <td  width="150" ><%=member.getMem_name()%></td>
    <td align="center"  width="150"><%=member.getMem_phone()%></td>
    <td align="center"  width="200"><%=member.getMem_address()%></td>
    <td align="center" width="100" ><%=member.getMem_job()%></td>
  </tr>
    <%  } //for %>
</table>
  <% } //else %>
  <!-- 페이징 처리 -->
  <%
   if(count > 0){//최소 레코드가 한개이상
	 //1.총페이지수 구하기
	 //                     122/10=12.2+122%10=>1 12.2+1.0=13.2=13
	 int pageCount=count/pageSize+(count%pageSize==0?0:1);
	 //2.시작페이지
	 int startPage=0;
	 if(currentPage%blockSize!=0){//1~9,11~19,21~29(10배수X)
		startPage=currentPage/blockSize*blockSize+1;//경계선때문 
	 }else{//10%10=0(10,20,30,40,,,)
	                   //((10/10)-1)*10+1=1 ,2->11
		startPage=((currentPage/blockSize)-1)*blockSize+1;
	 }
	 //종료페이지 //1+10-1=10,2+10-1=11
	 int endPage=startPage+blockSize-1;
	 System.out.println
	    ("startPage=>"+startPage+",endPage=>"+endPage);
	 //블럭별로 구분해서 링크 걸어서 출력()
	 if(endPage > pageCount) endPage=pageCount;//마지막=총페이지수
	 //1)11>10=>startPage
	 if(startPage > blockSize){%>
<a href="MemberList.jsp?pageNum=<%=startPage-blockSize %>">
[이전]</a> 
  <%}
	 //2)현재블럭(1,2,[3],4,,,,10)
     for(int i=startPage;i<=endPage;i++){%>
<a href="MemberList.jsp?pageNum=<%=i%>">[<%=i%>]</a>	
  <%}
	 //다음블럭  1~14<15
	 if(endPage <pageCount) {%>
<a href="MemberList.jsp?pageNum=<%=startPage+blockSize %>">
[다음]</a>
 <% 
	 }//다음블럭
   }//if(count > 0)
  %> 
</center>
</body>
</html>