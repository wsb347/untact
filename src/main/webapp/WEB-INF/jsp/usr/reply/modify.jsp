<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.sbs.untact.util.Util"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<c:set var="fileInputMaxCount" value="10" />

<script>
	ReplyModify__submited = false;
	function ReplyModify__checkAndSubmit(form) {
		if (ReplyModify__submited) {
			alert('처리중입니다.');
			return;
		}

		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			alert('내용을 입력해주세요.');
			form.body.focus();
			return false;
		}

		form.submit();
		ReplyModify__submited = true;
	}
</script>

<section class="section-1" method="POST">
	<div class="bg-white shadow-md rounded container mx-auto p-8 mt-8">
		<div class="w-full">
			<form onsubmit="ReplyModify__checkAndSubmit(this); return false;" action="doModify" method="POST" enctype="multipart/form-data">
				<div class="flex py-5 px-4">
					<!-- 아바타 이미지 -->
					<div class="flex-shrink-0">
						<img class="w-10 h-10 object-cover rounded-full shadow mr-2 cursor-pointer" alt="User avatar" src="${reply.writerThumbImgUrl}" onerror="this.src = 'https://via.placeholder.com/150?text=NO IMAGE';">
					</div>
					<div class="flex-grow px-1">
						<c:set var="redirectUrl" value="../article/detail?id=${reply.relId}" />
						<input type="hidden" name="redirectUrl" value="${redirectUrl}"/>
						<input type="hidden" name="id" value="${reply.id}"/>
						<div class="flex text-gray-400 text-light text-sm">
						
							<spqn>${reply.extra__writerName}</spqn>
							<span class="mx-1">·</span>
							<spqn>${reply.updateDate}</spqn>
						</div>
						<input value="${reply.bodyForPrint}" type="text" name="body" autofocus="autofocus"
						class="w-full py-2 pl-4 pr-10 text-sm bg-gray-100 border border-transparent appearance-none rounded-full placeholder-gray-400 focus:bg-white focus:outline-none focus:border-blue-500 focus:text-gray-900 focus:shadow-outline-blue" placeholder="내용을 입력해주세요." />
						<div class="mt-1">
							<span class="text-gray-400 cursor-pointer"> <span><i class="fas fa-thumbs-up"></i></span> <span>5,600</span>
							</span> <span class="ml-1 text-gray-400 cursor-pointer"> <span><i class="fas fa-thumbs-down"></i></span> <span>5,600</span>
							</span>
						</div>
					</div>
				</div>
				<div class="form-row flex flex-col lg:flex-row mt-5">
					<div class="lg:flex-grow">
						<div class="btns">
							<input type="submit" class="btn-primary bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded" value="수정">
							<input onclick="history.back();" type="button" class="btn-info bg-red-500 hover:bg-red-600 text-white font-bold py-2 px-4 rounded" value="취소">
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>