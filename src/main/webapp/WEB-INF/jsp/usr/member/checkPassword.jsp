<%@page import="com.sbs.untact.dto.Article"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jspf"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<script>
	let MemberCheckPassword__submitFormDone = false;
	function MemberCheckPassword__submitForm(form) {
		if (MemberCheckPassword__submitFormDone) {
			return;
		}
		form.loginPwInput.value = form.loginPwInput.value.trim();
		if (form.loginPwInput.value.length == 0) {
			alert('로그인비밀번호을 입력해주세요.');
			form.loginPwInput.focus();
			return;
		}
		form.loginPw.value = sha256(form.loginPwInput.value);
		form.loginPwInput.value = '';
		form.submit();
		MemberCheckPassword__submitFormDone = true;
	}
</script>

<section class="section section-login px-2">
	<div class="container mx-auto">
		<form method="POST" action="doCheckPassword" onsubmit="MemberCheckPassword__submitForm(this); return false;">
			<input type="hidden" name="redirectUri" value="${param.afterUri}" /> <input type="hidden" name="loginPw" />

			<div class="form-control">
				<label class="label"> 비밀번호 확인 </label> <input class="input input-bordered w-full" type="password" maxlength="30" name="loginPwInput" placeholder="로그인비밀번호를 입력해주세요." />
			</div>
			 <div class="mt-4 btn-wrap gap-1">
                <input type="submit" class="btn-primary bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded" value="확인">
				<input onclick="history.back();" type="button" class="btn-info bg-red-500 hover:bg-red-600 text-white font-bold py-2 px-4 rounded" value="취소">
            </div>
			
		</form>
	</div>
</section>
<%@ include file="../part/foot.jspf"%>