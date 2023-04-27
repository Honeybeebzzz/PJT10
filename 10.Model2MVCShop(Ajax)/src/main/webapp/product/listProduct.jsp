<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��ǰ ����</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

   //=====����Code �ּ� ó�� ��  jQuery ���� ======//
   // �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
   function fncGetProductList(currentPage) {
      //document.getElementById("currentPage").value = currentPage;
      $("#currentPage").val(currentPage)
         //document.detailForm.submit();
      $("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${pram.menu}").submit();
   }
   //===========================================//
   //==> �߰��Ⱥκ� : "�˻�" ,  userId link  Event ���� �� ó��
    $(function() {
       
      //==> �˻� Event ����ó���κ�
      //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
      //==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����. 
       $( "td.ct_btn01:contains('�˻�')" ).on("click" , function() {
         //Debug..
         //alert(  $( "td.ct_btn01:contains('�˻�')" ).html() );
         fncGetProductList(1);
      });
      
      
      //==> userId LINK Event ����ó��
      //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
      //==> 3 �� 1 ��� ���� : $(".className tagName:filter�Լ�") �����.
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
       
      //==> UI ���� �߰��κ�  :  userId LINK Event End User ���� ���ϼ� �ֵ��� 
      $( ".ct_list_pop td:nth-child(3)" ).css("color" , "blue");
      $("h7").css("color" , "blue");
      

      //==> �Ʒ��� �ּ��� �ϳ��� Ǯ�� ���� �����ϼ���.               
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

<!-- ////////////////// jQuery Event ó���� ����� /////////////////////////
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
						
							��ǰ ����
	
						}else{
	
						��ǰ �����ȸ
	
						}
				--%>
				 <%--String menu = request.getParameter("menu");�̰�
				  ${param.menu} �̶� ���� ����  --%>
	  
				<%-- <c:if test="${param.menu eq 'manage'}">��ǰ ����</c:if> 
				<c:if test="${param.menu eq 'search'}">��ǰ �����ȸ</c:if> --%>

		<c:choose>
		  <c:when test="${param.menu == 'manage'}">
		    �ǸŻ�ǰ����
		  </c:when>
		  <c:otherwise>
		    ��ǰ�����ȸ
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
					<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��</option>
					<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ����</option>

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
						
						<!-- ////////////////// jQuery Event ó���� ����� /////////////////////////
							<a href="javascript:fncGetUserList('1');">�˻�</a>
							////////////////////////////////////////////////////////////////////////////////////////////////// -->
						�˻�
						
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
		<td colspan="11" >��ü${resultPage.totalCount }  �Ǽ�, ���� ${resultPage.currentPage} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="250">��ǰ��
		<h7>(��ǰ�� click: ������)</h7></td>
		 				  
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="250">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="250">�������</td>	
		<td class="ct_line02"></td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<%--  /////////////////////// EL / JSTL �������� �ּ� ó�� ////////////////////////
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
		
		
					<a href="/updateTranCodeByProd.do?prodNo=<%=listvo.getProdNo() %>&tranCode=2">����ϱ�</a>
		
		</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	<% } %>/////////////////////// EL / JSTL �������� �ּ� ó�� //////////////////////// --%>
	
	
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
         
            <%-- /////////////////////// EL / JSTL �������� �ּ� ó�� //////////////////////// 
         <% if( resultPage.getCurrentPage() <= resultPage.getPageUnit() ){ %>
               �� ����
         <% }else{ %>
               <a href="javascript:fncGetProductList('<%=resultPage.getCurrentPage()-1%>')">�� ����</a>
         <% } %>

         <%   for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){   %>
               <a href="javascript:fncGetProductList('<%=i %>');"><%=i %></a>
         <%    }  %>
   
         <% if( resultPage.getEndUnitPage() >= resultPage.getMaxPage() ){ %>
               ���� ��
         <% }else{ %>
               <a href="javascript:fncGetProductList('<%=resultPage.getEndUnitPage()+1%>')">���� ��</a>
         <% } %>
             /////////////////////// EL / JSTL �������� �ּ� ó�� //////////////////////// --%>
         
         <c:set var="pageType" value="product" scope="request"/>
         <jsp:include page="../common/pageNavigator2.jsp"/>   
         
       </td>
   </tr>
</table>
<!--  ������ Navigator �� -->

</form>
</div>

</body>
</html>
      