<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.sbs.untact.util.Util"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<c:set var="fileInputMaxCount" value="10" />

<script>
	ReplyAdd__submited = false;
	function ReplyAdd__checkAndSubmit(form) {
		if (ReplyAdd__submited) {
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
		ReplyAdd__submited = true;
	}
</script>

<section class="section-1" method="POST">
	<div class="bg-white shadow-md rounded container mx-auto p-8 mt-8">
		<div class="w-full">
			<div class="flex flex-row mt-2 py-3">
				<div class="rounded-full border-2 border-pink-500">
					<img class="w-12 h-12 object-cover rounded-full shadow cursor-pointer" alt="User avatar" src="${article.writerThumbImgUrl}" onerror="this.src = 'https://via.placeholder.com/150?text=NO IMAGE';">
				</div>
				<div class="flex flex-col mb-2 ml-4 mt-1">
					<div class="text-gray-600 text-sm font-semibold">${article.extra__writer}</div>
					<div class="flex w-full mt-1">
						<div class="text-gray-400 font-thin text-xs">${article.regDate}</div>
					</div>
				</div>
			</div>
			<div class="border-b border-gray-100"></div>
			<div class="text-gray-400 font-medium text-sm mb-7 mt-6">
				<c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">
					<c:set var="fileNo" value="${String.valueOf(inputNo)}" />
					<c:set var="file" value="${article.extra.file__common__attachment[fileNo]}" />
					${file.mediaHtml}
				</c:forEach>
			</div>
			<div class="text-gray-600 font-semibold text-lg mb-2">${article.title}</div>
			<div class="text-gray-500 font-thin text-sm mb-6">${article.body}</div>
			

			<c:if test="${loginedMember != null}">
				<form method="POST" onsubmit="ReplyAdd__checkAndSubmit(this); return false;" action="../reply/doAdd" class="relative flex py-4 text-gray-600 focus-within:text-gray-400  border-t border-gray-100">
					<input type="hidden" name="relId" value="${article.id}" /> <input type="hidden" name="relTypeCode" value="article" /> <input type="hidden" name="redirectUrl" value="../article/detail?id=${article.id}" /> <span class="absolute inset-y-0 right-0 flex items-center pr-3">
						<button type="submit" class="p-1 focus:outline-none focus:shadow-none hover:text-blue-500">
							<i class="fas fa-comment-dots"></i>
						</button>
					</span> <input name="body" type="text" class="w-full py-2 pl-4 pr-10 text-sm bg-gray-100 border border-transparent appearance-none rounded-tg placeholder-gray-400 focus:bg-white focus:outline-none focus:border-blue-500 focus:text-gray-900 focus:shadow-outline-blue" style="border-radius: 25px" placeholder="댓글을 입력해주세요." autocomplete="off">
				</form>
			</c:if>

			<div>
				<c:forEach items="${replies}" var="reply">
					<div class="flex py-5 px-4">
						<!-- 아바타 이미지 -->
						<div class="flex-shrink-0">
							<img class="w-10 h-10 object-cover rounded-full shadow mr-2 cursor-pointer" alt="User avatar" src="${reply.writerThumbImgUrl}" onerror="this.src = 'https://via.placeholder.com/150?text=NO IMAGE';">
						</div>

						<div class="flex-grow px-1">
							<div class="flex text-gray-400 text-light text-sm">
								<spqn>${reply.extra__writerName}</spqn>
								<span class="mx-1">·</span>
								<spqn>${reply.updateDate}</spqn>
							</div>
							<div class="break-all">${reply.bodyForPrint}</div>
							<c:if test="${reply.extra__writerName == loginedMember.nickname }">
								<c:set var="redirectUrl" value="../article/detail?id=${article.id}" />
								<c:set var="modifyUrl" value="../reply/modify?id=${reply.id}"/>
								<a href="${modifyUrl}" class="text-blue-500 hover:underline">수정</a>
								<a onclick="if ( !confirm('삭제하시겠습니까?') ) return false;" href="../reply/doDelete?id=${reply.id}&redirectUrl=${redirectUrl}" class="ml-2 text-blue-500 hover:underline">삭제</a>
							</c:if>
						</div>
					</div>
				</c:forEach>
			</div>

			<div class="form-row flex flex-col lg:flex-row mt-5">
				<div class="lg:flex-grow">
					<div class="btns">
						<input onclick="history.back(); return false;" type="button" class="btn-info bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded" value="목록">
					</div>
				</div>
			</div>
		</div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>