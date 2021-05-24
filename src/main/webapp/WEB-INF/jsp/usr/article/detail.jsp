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

<section class="section-1">
	<div class="bg-white shadow-md rounded container mx-auto p-8 mt-8">
		<div class="w-full">
			<div class="flex flex-row mt-2 py-3">
				<div class="rounded-full border-2 border-pink-500">
					<img class="w-12 h-12 object-cover rounded-full shadow cursor-pointer" alt="User avatar" src="${article.writerThumbImgUrl}">
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
			<div class="flex justify-start mb-4 border-t border-gray-100">
				<div class="flex w-full mt-1 pt-2">

					<span class="bg-white transition ease-out duration-300 hover:text-red-500 border w-8 h-8 px-2 pt-1 text-center rounded-full text-gray-400 cursor-pointer mr-2"> <i class="far fa-heart"></i></span> <img class="inline-block object-cover w-8 h-8 text-white border-2 border-white rounded-full shadow-sm cursor-pointer" src="https://images.unsplash.com/photo-1491528323818-fdd1faba62cc?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=facearea&amp;facepad=2&amp;w=256&amp;h=256&amp;q=80" alt=""> <img class="inline-block object-cover w-8 h-8 -ml-2 text-white border-2 border-white rounded-full shadow-sm cursor-pointer" src="https://images.unsplash.com/photo-1550525811-e5869dd03032?ixlib=rb-1.2.1&amp;auto=format&amp;fit=facearea&amp;facepad=2&amp;w=256&amp;h=256&amp;q=80"
						alt=""> <img class="inline-block object-cover w-8 h-8 -ml-2 text-white border-2 border-white rounded-full shadow-sm cursor-pointer" src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=crop&amp;w=634&amp;q=80" alt=""> <img class="inline-block object-cover w-8 h-8 -ml-2 text-white border-2 border-white rounded-full shadow-sm cursor-pointer" src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=facearea&amp;facepad=2.25&amp;w=256&amp;h=256&amp;q=80" alt="">
				</div>
				<div class="flex justify-end w-full mt-1 pt-2">
					<span class="transition ease-out duration-300 hover:bg-blue-50 bg-blue-100 h-8 px-2 py-2 text-center rounded-full text-blue-400 cursor-pointer mr-2"> <svg xmlns="http://www.w3.org/2000/svg" fill="none" width="14px" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.684 13.342C8.886 12.938 9 12.482 9 12c0-.482-.114-.938-.316-1.342m0 2.684a3 3 0 110-2.684m0 2.684l6.632 3.316m-6.632-6l6.632-3.316m0 0a3 3 0 105.367-2.684 3 3 0 00-5.367 2.684zm0 9.316a3 3 0 105.368 2.684 3 3 0 00-5.368-2.684z"></path>
                  </svg>
					</span> <span class="transition ease-out duration-300 hover:bg-blue-500 bg-blue-600 h-8 px-2 py-2 text-center rounded-full text-gray-100 cursor-pointer"> <svg xmlns="http://www.w3.org/2000/svg" fill="none" width="14px" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"></path>
                  </svg>
					</span>
				</div>
			</div>
			
			<c:if test="${loginedMember != null}">
				<form method="POST" onsubmit="ReplyAdd__checkAndSubmit(this); return false;" action="../reply/doAdd" class="relative flex py-4 text-gray-600 focus-within:text-gray-400  border-t border-gray-100">
					<input type="hidden" name="relId" value="${article.id}" />
					<input type="hidden" name="relTypeCode" value="article" />
					<input type="hidden" name="redirectUrl" value="../article/detail?id=${article.id}" />
					<span class="absolute inset-y-0 right-0 flex items-center pr-3">
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
							<img class="w-10 h-10 object-cover rounded-full shadow mr-2 cursor-pointer" alt="User avatar" src="${reply.writerThumbImgUrl}">
						</div>

						<div class="flex-grow px-1">
							<div class="flex text-gray-400 text-light text-sm">
								<spqn>${reply.extra__writerName}</spqn>
								<span class="mx-1">·</span>
								<spqn>${reply.updateDate}</spqn>
							</div>
							<div class="break-all">${reply.bodyForPrint}</div>
							 <div class="mt-1">
                                <span class="text-gray-400 cursor-pointer">
                                    <span><i class="fas fa-thumbs-up"></i></span>
                                    <span>5,600</span>
                                </span>
                                <span class="ml-1 text-gray-400 cursor-pointer">
                                    <span><i class="fas fa-thumbs-down"></i></span>
                                    <span>5,600</span>
                                </span>
                            </div>
							<c:if test="${reply.extra__writerName == loginedMember.nickname }">
								<c:set var="redirectUrl" value="../article/detail?id=${article.id}"/>
								<a href="../reply/modify?id=${reply.id}&redirectUrl=${redirectUrl}" class="text-blue-500 hover:underline">수정</a>
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