<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.sbs.untact.util.Util"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<script>
	const ModifyForm__checkAndSubmitDone = false;
	let ModifyForm__validName= '';
	// 이름 중복체크 함수
	function ModifyForm__checkLoginIdDup() {
		const form = $('.name').get(0);
		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			return;
		}
		$.get('getNameDup', {
			name : form.name.value
		},
				function(data) {
					let colorClass = 'text-green-500';
					if (data.fail) {
						colorClass = 'text-red-500';
					}

					$('.nameInputMsg').html(
							"<span class='" + colorClass + "'>" + data.msg
									+ "</span>");
					if (data.fail) {
						form.name.focus();
					} else {
						ModifyForm__validName = data.body.name;
						form.name.focus();
					}
				}, 'json');
	}

	BoardModify__submited = false;
	function BoardModify__checkAndSubmit(form) {
		if (BoardModify__submited) {
			alert('처리중입니다.');
			return;
		}

		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			alert('이름을 입력해주세요.');
			form.name.focus();

			return false;
		}
		
		form.submit();
		BoardModify__submited = true;
	}
</script>

<section class="section-1">
	<div class="bg-white shadow-md rounded container mx-auto p-8 mt-8">
		<form onsubmit="BoardModify__checkAndSubmit(this); return false;" action="doModify" method="POST" enctype="multipart/form-data">
			<input type="hidden" name="id" class="form-row-input w-full rounded-sm" value="${board.id}" />
			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28">
					<span>코드</span>
				</div>
				<div class="lg:flex-grow">
					<h1>${board.code}</h1>
				</div>
			</div>
			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28">
					<span>이름</span>
				</div>
				<div class="lg:flex-grow">
					<input type="text" name="name" class="form-row-input w-full rounded-sm" placeholder="이름을 입력해주세요." value="${board.name}" />
				</div>
				<div class="nameInputMsg"></div>
			</div>
			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex-grow">
					<div class="btns">
						<input type="submit" class="btn-primary bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded" value="수정"> <input onclick="history.back();" type="button" class="btn-info bg-red-500 hover:bg-red-600 text-white font-bold py-2 px-4 rounded" value="취소">
					</div>
				</div>
			</div>
		</form>
	</div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>