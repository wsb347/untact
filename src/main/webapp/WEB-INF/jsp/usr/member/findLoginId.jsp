<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../part/head.jspf"%>

<script>
	const findLoginId__checkAndSubmitDone = false;
	function findLoginId__checkAndSubmit(form) {
		if (findLoginId__checkAndSubmitDone) {
			return;
		}

		form.name.value = form.name.value.trim();

		if (form.name.value.length == 0) {
			alert('이름을 입력해주세요.');
			form.name.focus();

			return;
		}

		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요.');
			form.email.focus();

			return;
		}

		form.submit();
		LoginForm__checkAndSubmitDone = true;
	}
</script>

<section class="section-login">
	<div class="container mx-auto min-h-screen flex items-center justify-center">
		<div class="w-full">
			<div class="logo-bar flex justify-center mt-3">
				<a href="#" class="logo"> <span> <i class="fas fa-people-arrows"></i>
				</span> <span>UNTACT</span>
				</a>
			</div>
			<form class="bg-white w-full shadow-md rounded px-8 pt-6 pb-8 mt-4" action="doFindLoginId" method="POST" onsubmit="findLoginIdForm__checkAndSubmit(this); return false;">
				<input type="hidden" name="redirectUrl" value="${param.redirectUrl}" />
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>이름</span>
					</div>
					<div class="p-1 md:flex-grow">
						<input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" autofocus="autofocus" type="text" placeholder="이름를 입력해주세요." name="name" maxlength="20" />
					</div>
				</div>
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>이메일</span>
					</div>
					<div class="p-1 md:flex-grow">
						<input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker" autofocus="autofocus" type="email" placeholder="이메일을 입력해주세요." name="email" maxlength="20" />
					</div>
				</div>
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1">
						<input class="bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded" type="submit" value="아이디찾기" />
						<input onclick="history.back();" type="button" class="btn-info bg-red-500 hover:bg-red-600 text-white font-bold py-2 px-4 rounded" value="취소">
						<a href="join" class="btn btn-link btn-sm mb-1" type="submit"><i class="fas fa-sign-in-alt"></i> 회원가입</a>
						<a href="findLoginPw" class="btn btn-link btn-sm mb-1" type="submit"><i class="fas fa-sign-in-alt"></i> 비밀번호 찾기</a>
					</div>
				</div>
			</form>

		</div>
	</div>
</section>

<%@ include file="../part/foot.jspf"%>