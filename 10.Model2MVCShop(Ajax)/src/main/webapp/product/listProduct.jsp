<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>상품 관리</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<!-- CDN(Content Delivery Network) 호스트 사용 -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

   //=====기존Code 주석 처리 후  jQuery 변경 ======//
   // 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
   function fncGetProductList(currentPage) {
      //document.getElementById("currentPage").value = currentPage;
      $("#currentPage").val(currentPage)
         //document.detailForm.submit();
      $("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${pram.menu}").submit();
   }
   //===========================================//
   //==> 추가된부분 : "검색" ,  userId link  Event 연결 및 처리
    $(function() {
       
      //==> 검색 Event 연결처리부분
      //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
      //==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함. 
       $( "td.ct_btn01:contains('검색')" ).on("click" , function() {
         //Debug..
         //alert(  $( "td.ct_btn01:contains('검색')" ).html() );
         fncGetProductList(1);
      });
      
      
      //==> userId LINK Event 연결처리
      //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
      //==> 3 과 1 방법 조합 : $(".className tagName:filter함수") 사용함.
//       $(  ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
//             //Debug..
//             //alert(  $( this ).text().trim() );
//             self.location ="/product/getProduct?prodNo="+$(this).text().trim();
//       });
      
       $(".ct_list_pop td:nth-child(3)" ).on("click" , function() {
          
          //self.location ="/product/getProduct?updateProduct?prodNo="+$(this).text().trim();
         if(($('#menu').attr('name')) == "manage") {
             self.location = "/product/updateProduct?prodNo="+$(this).children('input:hidden').val()+"&menu="+$('menu').attr('name');   
          }
         if(($('#menu').attr('name')) == "search") {
             self.location = "/product/getProduct?prodNo="+$(this).children('input:hidden').val()+"&menu="+$('menu').attr('name');            
         }                                         
      }); 
//        $(".ct_list_pop td:nth-child(3)" ).on("click" , function() {

//           $(window.parent.frames["rightFrame"].document.location).attr("href","/product/getProduct?menu=search");
//       }); 
       
      //==> UI 수정 추가부분  :  userId LINK Event End User 에게 보일수 있도록 
      $( ".ct_list_pop td:nth-child(3)" ).css("color" , "blue");
      $("h7").css("color" , "blue");
      

      //==> 아래의 주석을 하나씩 풀어 가며 이해하세요.               
      $(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
     // console.log ( $(".ct_list_pop:nth-child(1)" ).html() );
      //console.log ( $(".ct_list_pop:nth-child(2)" ).html() );
     // console.log ( $(".ct_list_pop:nth-child(3)" ).html() );
      //console.log ( $(".ct_list_pop:nth-child(4)" ).html() ); //==> ok
     // console.log ( $(".ct_list_pop:nth-child(5)" ).html() ); 
     console.log ( $(".ct_list_pop:nth-child(6)" ).html() ); //==> ok
     // console.log ( $(".ct_list_pop:nth-child(7)" ).html() ); 
   });   


</script>


</head>
<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
<form name="detailForm" action="/listUser.do" method="post">
////////////////////////////////////////////////////////////////////////////////////////////////// -->


<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
	<%--
						if(menu.equals("manage")){
						
							상품 관리
	
						}else{
	
						상품 목록조회
	
						}
				--%>
				 <%--String menu = request.getParameter("menu");이게
				  ${param.menu} 이랑 같은 뜻임  --%>
	  
				<%-- <c:if test="${param.menu eq 'manage'}">상품 관리</c:if> 
				<c:if test="${param.menu eq 'search'}">상품 목록조회</c:if> --%>

		<c:choose>
		  <c:when test="${param.menu == 'manage'}">
		    판매상품관리
		  </c:when>
		  <c:otherwise>
		    상품목록조회
		  </c:otherwise>
		</c:choose>
	
				</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
					<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품명</option>
					<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품가격</option>

			</select>
			<input type="text" name="searchKeyword" 
						value="${! empty search.searchKeyword ? search.searchKeyword : ""}"  
						class="ct_input_g" style="width:200px; height:20px" > 
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td> 
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						
						<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
							<a href="javascript:fncGetUserList('1');">검색</a>
							////////////////////////////////////////////////////////////////////////////////////////////////// -->
						검색
						
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >전체${resultPage.totalCount }  건수, 현재 ${resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="250">상품명
		<h7>(상품명 click: 상세정보)</h7></td>
		 				  
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="250">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="250">현재상태</td>	
		<td class="ct_line02"></td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<%--  /////////////////////// EL / JSTL 적용으로 주석 처리 ////////////////////////
	<%
		for(int i=0; i<list.size(); i++) {
			Product listvo = list.get(i);
	%>
	<tr class="ct_list_pop">
		<td align="center"><%= i + 1 %></td>
		<td></td>		
	<%
				if(menu.equals("manage")){
	%>					
				<td align="left"><a href="/updateProductView.do?prodNo=<%=listvo.getProdNo() %>&menu=manage"><%=listvo.getProdName() %></a></td>
	<%
				}else{
	%>
				<td align="left"><a href="/getProduct.do?prodNo=<%=listvo.getProdNo() %>&menu=search"><%=listvo.getProdName() %></a></td>
	<%
				}
	%>


		<td></td>
		<td align="left"><%=listvo.getPrice() %></td>
		<td></td>
		<td align="left"><%=listvo.getRegDate() %></td>
		<td></td>
		<td align="left">
		
		
					<a href="/updateTranCodeByProd.do?prodNo=<%=listvo.getProdNo() %>&tranCode=2">배송하기</a>
		
		</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	<% } %>/////////////////////// EL / JSTL 적용으로 주석 처리 //////////////////////// --%>
	
	
	<c:set var="i" value="0" />
   <c:forEach var="product" items="${list}">
      <c:set var="i" value="${ i+1 }" />
      <tr class="ct_list_pop">
         <td align="center">${ i }</td>
         
         <td></td>
         <!-- 
         
         <a href="
                  
         <c:choose>
         
            <c:when test= "${menu eq 'manage' }">
               /product/updateProduct
            </c:when>
            <c:otherwise>
               /product/getProduct
            </c:otherwise>
         </c:choose>
         
         ?prodNo=${product.prodNo}">${product.prodName}</a></td> -->
      <td align="left">
         <c:choose>         
            <c:when test= "${menu eq 'manage' }">
         <input type="hidden" id="menu" name="manage" value="${product.prodNo}"/>
            </c:when>
            <c:otherwise>
         <input type="hidden" id="menu" name="search" value="${product.prodNo}"/>    
            </c:otherwise>
         </c:choose>
         
            ${product.prodName} </td>
         <td></td>
         <td align="left">${product.price}</td>
         <td></td>

               
      </tr>
      <tr>
      <td colspan="11" bgcolor="D6D7D6" height="1"></td>
      </tr>
   </c:forEach>
</table>



<!-- PageNavigation Start... -->
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
   <tr>
      <td align="center">
         
         <input type="hidden" id="currentPage" name="currentPage" value=""/>
         
            <%-- /////////////////////// EL / JSTL 적용으로 주석 처리 //////////////////////// 
         <% if( resultPage.getCurrentPage() <= resultPage.getPageUnit() ){ %>
               ◀ 이전
         <% }else{ %>
               <a href="javascript:fncGetProductList('<%=resultPage.getCurrentPage()-1%>')">◀ 이전</a>
         <% } %>

         <%   for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){   %>
               <a href="javascript:fncGetProductList('<%=i %>');"><%=i %></a>
         <%    }  %>
   
         <% if( resultPage.getEndUnitPage() >= resultPage.getMaxPage() ){ %>
               이후 ▶
         <% }else{ %>
               <a href="javascript:fncGetProductList('<%=resultPage.getEndUnitPage()+1%>')">이후 ▶</a>
         <% } %>
             /////////////////////// EL / JSTL 적용으로 주석 처리 //////////////////////// --%>
         
         <c:set var="pageType" value="product" scope="request"/>
         <jsp:include page="../common/pageNavigator2.jsp"/>   
         
       </td>
   </tr>
</table>
<!--  페이지 Navigator 끝 -->

</form>
</div>

</body>
</html>
      