<%@page import="vo.ItemBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Shop ─ Café TinkerVell</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link
	href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Josefin+Sans:400,700"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Great+Vibes"
	rel="stylesheet">

<link rel="stylesheet" href="./css/open-iconic-bootstrap.min.css">
<link rel="stylesheet" href="./css/animate.css">

<link rel="stylesheet" href="./css/owl.carousel.min.css">
<link rel="stylesheet" href="./css/owl.theme.default.min.css">
<link rel="stylesheet" href="./css/magnific-popup.css">

<link rel="stylesheet" href="./css/aos.css">

<link rel="stylesheet" href="./css/ionicons.min.css">

<link rel="stylesheet" href="./css/bootstrap-datepicker.css">
<link rel="stylesheet" href="./css/jquery.timepicker.css">


<link rel="stylesheet" href="./css/flaticon.css">
<link rel="stylesheet" href="./css/icomoon.css">
<link rel="stylesheet" href="./css/style.css">

<!---------------------- 스마트 에디터 가져오는 영역 시작 ---------------------->
<%
	String ctx = request.getContextPath(); //콘텍스트명 얻어오기.
%>
<!-- SmartEditor를 사용하기 위해서 다음 js파일을 추가 (경로 확인) -->
<script type="text/javascript" src="<%=ctx%>/se2/js/HuskyEZCreator.js"
	charset="utf-8"></script>
<script type="text/javascript" src="<%=ctx%>/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js"
	charset="utf-8"></script>
	
<!-- jQuery를 사용하기위해 jQuery라이브러리 추가 -->
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.9.0.min.js"></script>

<script type="text/javascript">
	var oEditors = [];
	
	$(function(){
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
		    elPlaceHolder: "ir1",// textarea id로 변경해야 함 [id = ir1(155번째줄)]
		    sSkinURI: "<%=ctx%>/se2/SmartEditor2Skin.html",
		    fCreator: "createSEditor2",
// 		    fOnAppLoad : function(){
// 				oEditors.getById["ir1"].exec("PASTE_HTML", ['<span style="color: #999;" id="placeholder">이미지 퀵 에디터는 Microsoft Edge 또는 Window Explorer에서만 지원됩니다.</span>']);
// 		    }
		});
	
		//저장버튼 클릭시 form 전송
		$("#save").click(function() {
			oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []); // textarea id 변경해야 함 [id = ir1(155번째줄)]
			$("#frm").submit(); // form id로 변경해야 함 [id = frm(146)]
		});
		
		$("#reset").click(function() {
			if (confirm("정말 다시 쓰겠습니까? 작업 내용이 모두 사라집니다.") == true) {
				$("#ir1").reset();
			} else {
				return;
			}
		});
        
		
	});
	 
	// textArea에 이미지 첨부
	function pasteHTML(filepath){
		var sHTML = '<img src="<%=ctx%>/img_upload/'+filepath+'" style="max-width: 100%; height: auto; margin: 10px;">';
	    oEditors.getById["ir1"].exec("PASTE_HTML", [sHTML]); // textarea id 변경해야 함 [id = ir1(155번째줄)]
	}
	
// 	oEditors.getById["ir1"].exec("PASTE_HTML", ['기본텍스트입니다.']); // placeholder
	
</script>
<!---------------------- 스마트 에디터 가져오는 영역 끝 ---------------------->
<style type="text/css">
	.frmTitle {
		border: 0.1px solid #ccc;
		padding: 5px;
		color: white;
		background: rgba(0,0,0,0);
		width: 100%;
	}
	#favor td {
		text-align: left;
	}
	#favor select {
 		margin-top: 30px; 
 		margin: 0 10px;
 		width: 85px; 
 		text-align-last: center;
	}
</style>

<%
	ItemBean itemBean = (ItemBean) request.getAttribute("itemBean");
%>
</head>

<body>

	<header>
	<jsp:include page="../inc/header.jsp"></jsp:include>
	</header>
	<!-- END nav -->


	<section class="ftco-section" style="margin-top: 100px; margin-bottom: 100px;">
		<div class="container">
			<form id="frm" action="itemModifyPro.em?item_num=<%=itemBean.getItem_num() %>&item_favor_num=<%=itemBean.getItem_favor_num() %>" method="post" enctype="multipart/form-data">
				<h2 style="margin: 30px 100px;">상품 수정</h2>
				<table style="width: 100%; text-align: center;">
					<tr>
						<td>상품번호 : </td>
						<td><input type="text" id="item_num" name="item_num" class="frmTitle" placeholder="<%=itemBean.getItem_num() %>" readonly="readonly"/></td>
					</tr>
					<tr>
						<td>상품명 : </td>
						<td><input type="text" id="item_name" name="item_name" class="frmTitle" value="<%=itemBean.getItem_name() %>" required="required"/></td>
					</tr>
					<tr>
						<td>가격 : </td>
						<td><input type="text" id="item_price" name="item_price" class="frmTitle" value="<%=itemBean.getItem_price() %>" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required="required"/></td>
					</tr>
					<tr>
						<td>상품 이미지 : </td>
						<td><input type="file" id="item_img" name="item_img" class="frmTitle" value="<%=itemBean.getItem_img() %>"  required="required"/></td>
					</tr>
					<tr>
						<td>간단 설명 : </td>
						<td><textarea rows="10" cols="30" id="item_info" name="item_info" style="width: 100%; height: 200px;"
						required="required"><%=itemBean.getItem_info()%></textarea></td>
					</tr>
					<tr>
						<td>재고 : </td>
						<td><input type="text" id="item_amount" name="item_amount" class="frmTitle" value="<%=itemBean.getItem_amount() %>" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required="required"/></td>
					</tr>
					<tr>
						<td>상세설명 이미지 : </td>
						<td><input type="file" id="item_content" name="item_content" class="frmTitle" value="<%=itemBean.getItem_content()%>"  required="required"/></td>
					</tr>
					<tr>
						<td colspan="2">&nbsp;</td>
					</tr>
					<tr id="favor" style="margin-top: 30px;">
						<td style="text-align: center; ">상세 선택 : </td>
						<td>Aroma
							<select id="item_favor_aroma" name="item_favor_aroma" >
								<option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option>
							</select>
							Acidity 
							<select id="item_favor_acidity" name="item_favor_acidity" >
								<option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option>
							</select>
							Sweetness 
							<select id="item_favor_sweetness" name="item_favor_sweetness" >
								<option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option>
							</select>
							Bitterness 
							<select id="item_favor_bitterness" name="item_favor_bitterness"  >
								<option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option>
							</select>
							Body 
							<select id="item_favor_body" name="item_favor_body"  >
								<option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option>
							</select>
						</td>
					</tr>
<!-- 					<tr> -->
<!-- 					<tr> -->
<!-- 						<td>상품 취향 번호 : </td> -->
<%-- 						<td><input type="text" id="item_favor_num" name="item_favor_num" class="frmTitle" placeholder="<%=itemBean.getItem_favor_num() %>" readonly="readonly"/></td> --%>
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td>Aroma : </td> -->
<%-- 						<td><input type="text" id="item_favor_aroma" name="item_favor_aroma" class="frmTitle" value="<%=itemBean.getItem_favor_aroma() %>"  required="required"/></td> --%>
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td>Acidity : </td> -->
<%-- 						<td><input type="text" id="item_favor_acidity" name="item_favor_acidity" class="frmTitle" value="<%=itemBean.getItem_favor_acidity() %>"  required="required"/></td> --%>
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td>Sweetness : </td> -->
<%-- 						<td><input type="text" id="item_favor_sweetness" name="item_favor_sweetness" class="frmTitle" value="<%=itemBean.getItem_favor_sweetness() %>"  required="required"/></td> --%>
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td>Bitterness : </td> -->
<%-- 						<td><input type="text" id="item_favor_bitterness" name="item_favor_bitterness" class="frmTitle" value="<%=itemBean.getItem_favor_bitterness() %>"  required="required"/></td> --%>
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td>Body : </td> -->
<%-- 						<td><input type="text" id="item_favor_body" name="item_favor_body" class="frmTitle" value="<%=itemBean.getItem_favor_body() %>"  required="required"/></td> --%>
<!-- 					</tr> -->
				</table>
				<br><br>
				<div style="float: left; width: 33%;">				
					<input type="reset" class="btn btn-primary py-3 px-4" style="color: black;" id="reset" value="다시쓰기" />
				</div>
				<div style="float: right; text-align: right; width: 66%;">	
					<input type="submit"  class="btn btn-primary py-3 px-4" style="color: black;" id="save" value="수정하기" /> 
					<input type="button" class="btn btn-primary py-3 px-4" style="color: black;" id="delete" value="삭제하기" onclick="location.href='./itemDeleteForm.em?item_num=<%=itemBean.getItem_num()%>&item_favor_num=<%=itemBean.getItem_favor_num() %>'"/>
				</div>
			</form>
		</div>
	</section>
	<!-- .section -->
	
	
<jsp:include page="../inc/footer.jsp"></jsp:include>

	<!-- loader -->
	<div id="ftco-loader" class="show fullscreen">
		<svg class="circular" width="48px" height="48px">
			<circle class="path-bg" cx="24" cy="24" r="22" fill="none"
				stroke-width="4" stroke="#eeeeee" />
			<circle class="path" cx="24" cy="24" r="22" fill="none"
				stroke-width="4" stroke-miterlimit="10" stroke="#F96D00" /></svg>
	</div>


	<script src="./js/jquery.min.js"></script>
	<script src="./js/jquery-migrate-3.0.1.min.js"></script>
	<script src="./js/popper.min.js"></script>
	<script src="./js/bootstrap.min.js"></script>
	<script src="./js/jquery.easing.1.3.js"></script>
	<script src="./js/jquery.waypoints.min.js"></script>
	<script src="./js/jquery.stellar.min.js"></script>
	<script src="./js/owl.carousel.min.js"></script>
	<script src="./js/jquery.magnific-popup.min.js"></script>
	<script src="./js/aos.js"></script>
	<script src="./js/jquery.animateNumber.min.js"></script>
	<script src="./js/bootstrap-datepicker.js"></script>
	<script src="./js/jquery.timepicker.min.js"></script>
	<script src="./js/scrollax.min.js"></script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
	<script src="./js/google-map.js"></script>
	<script src="./js/main.js"></script>

</body>
</html>