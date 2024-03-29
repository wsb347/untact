<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.sbs.untact.util.Util"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<script>
	MemberModify__submited = false;
	function MemberModify__checkAndSubmit(form) {
		if (MemberModify__submited) {
			alert('처리중입니다.');
			return;
		}
		if (MemberModify__submited) {
			return;
		}
		form.loginPwInput.value = form.loginPwInput.value.trim();
		if (form.loginPwInput.value.length == 0) {
			alert('로그인비번을 입력해주세요.');
			form.loginPwInput.focus();
			return;
		}
		if (form.loginPwConfirm.value.length == 0) {
			alert('로그인비번 확인을 입력해주세요.');
			form.loginPwConfirm.focus();
			return;
		}
		if (form.loginPwInput.value != form.loginPwConfirm.value) {
			alert('로그인비번이 일치하지 않습니다.');
			form.loginPwConfirm.focus();
			return;
		}

		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			alert('이름을 입력해주세요.');
			form.name.focus();
			return;
		}
		form.nickname.value = form.nickname.value.trim();
		if (form.nickname.value.length == 0) {
			alert('닉네임을 입력해주세요.');
			form.nickname.focus();
			return;
		}
		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요.');
			form.email.focus();
			return;
		}
		form.cellphoneNo.value = form.cellphoneNo.value.trim();
		if (form.cellphoneNo.value.length == 0) {
			alert('휴대전화번호를 입력해주세요.');
			form.cellphoneNo.focus();
			return;
		}

		function startUpload(onSuccess) {
			if (!form["file__member__" + param.id + "__common__attachment__1"].value) {
				onSuccess();
				return;
			}

			const formData = new FormData(form);

			$.ajax({
				url : '/common/genFile/doUpload',
				data : formData,
				processData : false,
				contentType : false,
				dataType : "json",
				type : 'POST',
				success : onSuccess
			});

			// 파일을 업로드 한 후
			// 기다린다.
			// 응답을 받는다.
			// onSuccess를 실행한다.
		}
		const submitForm = function(data) {
			if (data) {
				form.genFileIdsStr.value = data.body.genFileIdsStr;
			}
			
			form.loginPw.value = sha256(form.loginPwInput.value);
		    form.loginPwInput.value = '';
		    form.loginPwConfirm.value = '';

			form.submit();
			MemberModify__submited = true;
		}
		
		startUpload(submitForm);

	}
</script>

<section class="section-1">
	<div class="bg-white shadow-md rounded container mx-auto p-8 mt-8">
		<form onsubmit="MemberModify__checkAndSubmit(this); return false;" action="doModify" method="POST">
			<input type="hidden" name="genFileIdsStr" /> <input type="hidden" name="id" value="${member.id}" />
			<input type="hidden" name="loginPw" />
			<input type="hidden" name="checkPasswordAuthCode" value="${param.checkPasswordAuthCode}">
			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28">
					<span>아이디</span>
				</div>
				<div class="lg:flex-grow">${member.loginId}</div>
			</div>
			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28">
					<span>비밀번호</span>
				</div>
				<div class="lg:flex-grow">
					<input type="password" name="loginPwInput" autofocus="autofocus" class="form-row-input w-full rounded-sm" placeholder="로그인비밀번호를 입력해주세요." />
				</div>
			</div>
			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28">
					<span>비밀번호 확인</span>
				</div>
				<div class="lg:flex-grow">
					<input type="password" name="loginPwConfirm" autofocus="autofocus" class="form-row-input w-full rounded-sm" placeholder="로그인비밀번호 확인을 입력해주세요." />
				</div>
			</div>
			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28">
					<span>프로필이미지</span>
				</div>
				<div class="lg:flex-grow">
					<input accept="image/gif, image/jpeg, image/png" class="form-row-input w-full rounded-sm" autofocus="autofocus" type="file" placeholder="프로필이미지를 선택해주세요." name="file__member__${member.id}__common__attachment__1" maxlength="20" />
					<c:set var="fileNo" value="${String.valueOf(1)}" />
					<div class="max-w-xs">${member.extra.file__common__attachment[fileNo].mediaHtml}</div>
				</div>
			</div>
			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28">
					<span>이름</span>
				</div>
				<div class="lg:flex-grow">
					<input value="${member.name}" type="text" name="name" autofocus="autofocus" class="form-row-input w-full rounded-sm" placeholder="이름을 입력해주세요." />
				</div>
			</div>
			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28">
					<span>닉네임</span>
				</div>
				<div class="lg:flex-grow">
					<input value="${member.nickname}" type="text" name="nickname" autofocus="autofocus" class="form-row-input w-full rounded-sm" placeholder="별명을 입력해주세요." />
				</div>
			</div>
			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28">
					<span>이메일</span>
				</div>
				<div class="lg:flex-grow">
					<input value="${member.email}" type="email" name="email" autofocus="autofocus" class="form-row-input w-full rounded-sm" placeholder="이메일을 입력해주세요." />
				</div>
			</div>
			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28">
					<span>전화번호</span>
				</div>
				<div class="lg:flex-grow">
					<input value="${member.cellphoneNo}" type="text" name="cellphoneNo" autofocus="autofocus" class="form-row-input w-full rounded-sm" placeholder="전화번호를 입력해주세요." />
				</div>
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
