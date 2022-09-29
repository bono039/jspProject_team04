<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<style type="text/css">
   header {
      display: block;
   }
   
   
   .cate_select{
		width : 100%;
		height: 500px;
		/* display: flex; */
		justify-content: center;
		
	}
   
   
 	/* #cate_men:focus .cate_select{
		
		
	} */
	
	/* .gnbMenuWrap a:hover #cate_select {
      display: flex;
   } */
	
	.gnb-bottom-wrap > .inner > .gnbMenuWrap > ul > li:hover .cate_select{
		background-color: blue;
		/* display: ''; */
	} 
   
   .cate_div{
   		margin: 10px;
   }
   
   #cate_high{
   		font-weight: bold;
   		font-size: 40px;
   }
   
   .cate_low{
   		font-weight: bold;
   		font-size: 20px;
   		line-height: 40px;
   }
   
   
   .gnb-wrap {
      height: 145px;
      font-family: "Montserrat","Noto Sans KR",sans-serif;
   }
   .gnb-top-wrap {
      height: 98px;
   }
   .gnb-top-wrap .inner {
      position: relative;
      display: flex;
      height: 100%;
      width: 1200px;
      text-align: center;
      margin: 0 auto;
   }
   .gnb-top-wrap .inner a {
      display: flex;
       align-items: center;
       justify-content: center;
       vertical-align: middle;
       float: left;
   }
   .gnb-top-wrap .inner .gnb-search-wrap {
       position: relative;
       width: 465px;
       margin: 0 auto;
       padding-top: 20px; 
   }
   .gnb-top-wrap .inner .gnb-search-wrap input[type=search] {
       height: 34px;
       padding: 25px 72px 15px 9px;
       border: none;
       border-bottom: 2px solid #000;
       font-size: 14px;
   }
   .gnb-top-wrap .inner .gnb-search-wrap input[type=search]:focus {
       outline: none;
   }
   .gnb-top-wrap .inner .gnb-search-wrap form {
      position: relative;
   }
   .gnb-top-wrap .inner .gnb-search-wrap form button {
      position: absolute;
      bottom: 0;
      border: 0;
      outline: 0;
      border-bottom: 2px solid #000;
      background-color: white;
   }
   .gnb-top-wrap .inner .util-list-wrap .util-list {
      margin-top: 20px;
   }
   .gnb-top-wrap .inner .util-list-wrap .util-list li {
      display: flex;
      flex-direction: column;
      float: left;
      margin: 10px;   
   }
   .gnb-top-wrap .inner .util-list-wrap .util-list li a {
      text-decoration: none;
      align-items: center;
      color: black;
   }
   .gnb-bottom-wrap {
        position: relative;
      background-color: #ee1c25;
      height: 48px;  
      min-width: 1200px; 
   }
   .gnb-bottom-wrap .inner {
      position: relative;
      display: flex;
      justify-content: center;
      width: 1200px;
      height: 100%;
      margin: 0 auto;
   }
   .gnb-bottom-wrap .inner .gnb-menu {
      float: left;
      font-size: 16px;
       font-weight: 500;
       line-height: 48px;
   }
    .gnb-bottom-wrap .inner .gnb-menu li {
      display: inline-block;
      text-align: center;
      margin: 0 70px;
   }
   .gnb-bottom-wrap .inner .gnb-menu li a {
      text-decoration: none;
      color: #fff;
   }
   
</style>
<script type="text/javascript" src="../js/jquery.js"></script>
<c:set var="loginId" value="${empty sessionScope.mem_id ? '' : sessionScope.mem_id}"/>
<c:set var="loginOut" value="${loginId == '' ? 'LOGIN' : 'LOGOUT'}"/>
<c:set var="loginOutLink" value="${loginId == '' ? '/member/loginForm.do' : '/member/logout.do' }"/>
<c:set var="joinMy" value="${loginId == '' ? 'JOIN' : 'MY' }"/>
<c:set var="joinMyLink" value="${loginId == '' ? '/member/writeForm.do' : '#' }"/>
   <header>
      <div class="gnb-wrap">
         <div class="gnb-top-wrap">
            <div class="inner">
               <a href="${pageContext.request.contextPath }">
                  <img src="https://image.a-rt.com/art/system/site/202207/1658299296317.png">
               </a>
              	<div class="gnb-search-wrap">
                  <form action="${pageContext.request.contextPath }/category/searchView.do" id="searchViewForm">
                     <input type="search" name="searchBar" id="searchBar" value="${searchWord }" onclick="goSearch()">
                     <button class="material-icons" id="searchButton">search</button><!-- 버튼 클릭되면 진짜 찾는걸로 -->
                  </form>
               </div>
               <div class="util-list-wrap">
                  <ul class="util-list">
                  <c:if test="${sessionScope.mem_id == 'admin' }">
                	<li>
                        <a href="#" class="material-symbols-outlined">person</a>
                        <a href="#" style="font-size: 10px;">관리자</a>
                     </li>
                  </c:if>
                     <li>
                        <a href="../manage/noticeReal.jsp" class="material-symbols-outlined"><img src="https://cdn-icons-png.flaticon.com/512/584/584648.png" width="24" height="24"></a>
                        <a href="#" style="font-size: 10px;">NOTICE</a>
                     </li>
                     <li>
                        <a href="${pageContext.request.contextPath }${loginOutLink }" class="material-symbols-outlined">${loginOut }</a>
                        <a href="#" style="font-size: 10px;">${loginOut }</a>
                     </li>
                     <li>
                        <a href="${pageContext.request.contextPath }${joinMyLink}" class="material-symbols-outlined">person</a>
                        <a href="#" style="font-size: 10px;">${joinMy }</a>
                     </li>
                     <li>
                        <a href="${pageContext.request.contextPath }/basket/goToBasket.do" class="material-symbols-outlined">shopping_cart</a>
                        <a href="#" style="font-size: 10px;">CART</a>
                     </li>
                  </ul>
               </div>
            </div>
         </div>
         <div class="gnb-bottom-wrap">
            <div class="inner">
               <div class="gnbMenuWrap">
                  <ul class="gnb-menu">
                     <li id="li_brand">
                        <a href="#" style="color: #ffe100;">BRAND</a>
                     </li>
                     <li id="li_men">
                       <a href="${pageContext.request.contextPath }/category/men3.do?gender=0" >MEN</a>
                     </li>
                     <li id="li_women">
                        <a href="${pageContext.request.contextPath }/category/women.do?gender=1">WOMEN</a>
                     </li>
                     
                  </ul>
               </div>
            </div>
         </div>
      </div>
      <div class="cate_select" style="display:none">
	                  <div class="cate_div">
						<h1 id="cate_high"></h1>
						<hr>
						<ul class="cate_low" id="cate_low">
							
						</ul>
						<button id="close">닫기</button>
						</div>
					</div>
      
      
      
      <!-- 
		
	
       -->
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">
	function goSearch() {
		
		
		window.open('${pageContext.request.contextPath }/category/goSearch.do','_blank','width=1000px','height=1000px');
		
	}
	
	
	
	////남성탭 올렸을때 카테고리 메뉴 나오는 부분
	$('.gnbMenuWrap > ul > #li_men').mouseover(function() {
		
		$.ajax({
			url : 'findCate.do',
			dataType : 'html',
			data : {result : 'men'},
			success : function(data) {
				console.log(data);
				$('#cate_low').html(data);
			}
		})
		$('#cate_high').text('남성');
		$('.cate_select').css('display', 'flex');
	});
	
	//여성탭 올렸을때 카테고리 메뉴 나오는 부분
	$('.gnbMenuWrap > ul > #li_women').mouseover(function() {
		
		$.ajax({
			url : 'findCate.do',
			dataType : 'html',
			data : {result : 'women'},
			success : function(data) {
				console.log(data);
				$('#cate_low').html(data);
			}
		})
		$('#cate_high').text('여성');
		$('.cate_select').css('display', 'flex');
	});
	
	/* $('.gnbMenuWrap > ul > li').mouseout(function() {
		$('.cate_select').css('display', 'none');
	}); */
	//카테고리 메뉴 닫기
	$('#close').click(function() {
		$('.cate_select').css('display', 'none');
	})
</script>

	

   </header>
