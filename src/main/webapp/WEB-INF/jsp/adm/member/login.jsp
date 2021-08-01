<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../part/head.jspf"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<script>
	const LoginForm__checkAndSubmitDone = false;
	function LoginForm__checkAndSubmit(form) {
		if (LoginForm__checkAndSubmitDone) {
			return;
		}

		form.loginId.value = form.loginId.value.trim();

		if (form.loginId.value.length == 0) {
			alert('아이디를 입력해주세요.');
			form.loginId.focus();

			return;
		}
		
		form.loginPwInput.value = form.loginPwInput.value.trim();

		if (form.loginPwInput.value.length == 0) {
			alert('비밀번호를 입력해주세요.');
			form.loginPwInput.focus();

			return;
		}
		
		 form.loginPw.value = sha256(form.loginPwInput.value);
		 form.loginPwInput.value = '';

		form.submit();
		LoginForm__checkAndSubmitDone = true;
	}
</script>

<section class="section-login">
	<div
		class="container mx-auto min-h-screen flex items-center justify-center">
		<div class="w-full">
			<div class="logo-bar flex justify-center mt-3">
				<a href="#" class="logo"> <span> <i class="fas fa-tint"></i>
				</span> <span>물방울</span>
				</a>
			</div>
			<form class="bg-white w-full shadow-md rounded px-8 pt-6 pb-8 mt-4"
				action="doLogin" method="POST"
				onsubmit="LoginForm__checkAndSubmit(this); return false;">
				<input type="hidden" name="redirectUrl" value="${param.redirectUrl}" />
				<input type="hidden" name="loginPw" />
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>아이디</span>
					</div>
					<div class="p-1 md:flex-grow">
						<input
							class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker"
							autofocus="autofocus" type="text" placeholder="아이디를 입력해주세요."
							name="loginId" maxlength="20" />
					</div>
				</div>
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>비밀번호</span>
					</div>
					<div class="p-1 md:flex-grow">
						<input
							class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker"
							autofocus="autofocus" type="password"
							placeholder="비밀번호를 입력해주세요." name="loginPwInput" maxlength="20" />
					</div>
				</div>
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1">
						<input
							class="bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded"
							type="submit" value="로그인" /> 
							<a href="join"
							class="bg-green-500 hover:bg-green-600 text-white font-bold py-2 px-4 rounded"
							type="submit">회원가입</a> 
							<a href="findLoginId"
							class="btn btn-link btn-sm mb-1"
							type="submit"><i class="fas fa-sign-in-alt"></i> 아이디 찾기</a> 
							<a href="findLoginPw"
							class="btn btn-link btn-sm mb-1"
							type="submit"><i class="fas fa-sign-in-alt"></i> 비밀번호 찾기</a> 
					</div>
				</div>
			</form>

		</div>
	</div>
</section>

<%@ include file="../part/foot.jspf"%>