/**
 * xhr객체를 생성->jsp로 요청->응답->콜백함수로 출력
 */
var xhrObject;//xhr객체(전역변수)

//1.xhr객체생성
function createXHR(){
		 if(window.XMLHttpRequest){ 
	          xhrObject=new XMLHttpRequest();//객체생성
	      	 //alert(xhrObject);
		}
	}

//2.중복id를 입력->처리해주는 함수
function idCheck(id){
	if(id==""){//입력안했을때
		//var mem_id=document.getElementById("ducheck");
		var mem_id=$("ducheck");
		//alert(mem_id);
		$("ducheck").innerHTML="<font color='red'>아이디를 먼저입력</font>"
		//document.regForm.mem_id.focus();  마우스커서 집어넣기
		$("mem_id").focus();
		return false;
	}
	//1.xhr객체생성
	createXHR();//xhrObject
	var url="http://localhost:8090/JspMember/IdCheck.jsp?"+getParameterValues()
	//alert(url);
	
	//2.콜백함수를 지정
	//alert(xhrObject) undefined(객체생성X)
	xhrObject.onreadystatechange=resultProcess;
	
	//3.open함수를 이용해서 서버에 요청준비
	xhrObject.open("Get",url,true);
	
	//4.send 호출
	xhrObject.send(null);
}

//3.파라미터값을 처리해주는 함수(서버의 메모리 제거)
function getParameterValues(){
	var mem_id=$("mem_id").value
	//서버캐시에 요청->메모리에 저장하지 않는 방법
	//파리미터값을 하나 전달할때 오늘날짜를 같이 출력시켜주는 매개변수를 첨부 => 날짜는 같을수 없어서 날짜를 붙이면 항상 달라지기떄문에 구분하기위해사용
	return "mem_id="+mem_id+"&timestamp="+new Date().getTime()
}

//4.콜백함수
function resultProcess(){
	//alert("resultProcess");
	if(xhrObject.readyState==4){//서버가 요청을 다 받았다면
		if(xhrObject.status==200){//서버의 결과를 가 보내줬다면
			var result=xhrObject.responseText;//태그+문자열=>문자열
			$("ducheck").innerHTML=result;
		}
	}
}

