<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jspf"%>

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
		
		form.loginPw.value = form.loginPw.value.trim();

		if (form.loginPw.value.length == 0) {
			alert('비밀번호를 입력해주세요.');
			form.loginPw.focus();

			return;
		}
		
		form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
		
		if (form.loginPwConfirm.value.length == 0) {
			alert('비밀번호 확인을 입력해주세요.');
			form.loginPwConfirm.focus();

			return;
		}

		if (form.loginPw.value != form.loginPwConfirm.value) {
			alert('비밀번호가 일치하지 않습니다.');
			form.loginPwConfirm.focus();

			return;
		}
		
		form.nickname.value = form.nickname.value.trim();
		
		if (form.nickname.value.length == 0) {
			alert('닉네임을 입력해주세요.');
			form.nickname.focus();

			return;
		}
		
		form.name.value = form.name.value.trim();
		
		if (form.name.value.length == 0) {
			alert('이름을 입력해주세요.');
			form.name.focus();

			return;
		}
		
		form.cellphoneNo.value = form.cellphoneNo.value.trim();
		
		if (form.cellphoneNo.value.length == 0) {
			alert('전화번호를 입력해주세요.');
			form.cellphoneNo.focus();

			return;
		}
		
		form.email.value = form.email.value.trim();
		
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
	<div
		class="container mx-auto min-h-screen flex items-center justify-center">
		<div class="w-full">
			<div class="logo-bar flex justify-center mt-3">
				<a href="#" class="logo"> <span> <i
						class="fas fa-people-arrows"></i>
				</span> <span>UNTACT</span>
				</a>
			</div>
			<section class="section-1">
				<div class="bg-white shadow-md rounded container mx-auto p-8 mt-6">
					<form action="doJoin" method="POST" enctype="multipart/form-data"
					onsubmit="LoginForm__checkAndSubmit(this); return false;">
						<div class="form-row flex flex-col lg:flex-row">
							<div class="lg:flex lg:items-center lg:w-28">
								<span>아이디</span>
							</div>
							<div class="lg:flex-grow">
								<input type="text" name="loginId" autofocus="autofocus"
									class="form-row-input w-full rounded-sm"
									placeholder="아이디를 입력해주세요." />
							</div>
						</div>
						<div class="form-row flex flex-col lg:flex-row">
							<div class="lg:flex lg:items-center lg:w-28">
								<span>비밀번호</span>
							</div>
							<div class="lg:flex-grow">
								<input type="password" name="loginPw" autofocus="autofocus"
									class="form-row-input w-full rounded-sm"
									placeholder="비밀번호를 입력해주세요." />
							</div>
						</div>
						<div class="form-row flex flex-col lg:flex-row">
							<div class="lg:flex lg:items-center lg:w-28">
								<span>비밀번호 확인</span>
							</div>
							<div class="lg:flex-grow">
								<input type="password" name="loginPwConfirm" autofocus="autofocus"
									class="form-row-input w-full rounded-sm"
									placeholder="비밀번호를 입력해주세요." />
							</div>
						</div>
						<div class="form-row flex flex-col lg:flex-row">
							<div class="lg:flex lg:items-center lg:w-28">
								<span>이름</span>
							</div>
							<div class="lg:flex-grow">
								<input type="text" name="name" autofocus="autofocus"
									class="form-row-input w-full rounded-sm"
									placeholder="이름을 입력해주세요." />
							</div>
						</div>
						<div class="form-row flex flex-col lg:flex-row">
							<div class="lg:flex lg:items-center lg:w-28">
								<span>닉네임</span>
							</div>
							<div class="lg:flex-grow">
								<input type="text" name="nickname" autofocus="autofocus"
									class="form-row-input w-full rounded-sm"
									placeholder="닉네임을 입력해주세요." />
							</div>
						</div>
						<div class="form-row flex flex-col lg:flex-row">
							<div class="lg:flex lg:items-center lg:w-28">
								<span>휴대전화번호</span>
							</div>
							<div class="lg:flex-grow">
								<input type="tel" name="cellphoneNo" autofocus="autofocus"
									class="form-row-input w-full rounded-sm"
									placeholder="전화번호를 입력해주세요. (- 없이 입력해주세요)" maxlength="11"/>
							</div>
						</div>
						<div class="form-row flex flex-col lg:flex-row">
							<div class="lg:flex lg:items-center lg:w-28">
								<span>이메일</span>
							</div>
							<div class="lg:flex-grow">
								<input type="email" name="email" autofocus="autofocus"
									class="form-row-input w-full rounded-sm"
									placeholder="이메일을 입력해주세요." maxlength="100"/>
							</div>
						</div>
						<div class="form-row flex flex-col lg:flex-row">
							<div class="lg:flex-grow">
								<div class="btns">
									<input type="submit"
										class="btn-primary bg-blue-500 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded"
										value="가입"> <input onclick="history.back();"
										type="button"
										class="btn-info bg-red-500 hover:bg-red-dark text-white font-bold py-2 px-4 rounded"
										value="취소">
								</div>
							</div>
						</div>
					</form>
				</div>
			</section>
		</div>
	</div>
</section>
<%@ include file="../part/foot.jspf"%>