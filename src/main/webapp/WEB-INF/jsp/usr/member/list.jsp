<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.sbs.untact.util.Util"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/mainLayoutHead.jspf"%>

<section class="section-1">
	<div class="bg-white shadow-md rounded container mx-auto p-8 mt-8">
		<form class="flex mt-3">
			<select name="searchKeywordType">			
				<option value="nickname">닉네임</option>
				<option value="loginId">아이디</option>
			</select>
			<input class="ml-3 shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" name="searchKeyword" type="text" placeholder="검색어를 입력해주세요." value="${param.searchKeyword}" /> <input class="ml-3 btn-primary bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded" type="submit" value="검색" />
			<script>
				if ( param.searchKeywordType ) {
					$('.section-1 select[name="searchKeywordType"]').val(param.searchKeywordType);
				}
			</script>
		</form>
		<c:forEach items="${members}" var="member">
			<c:set var="detailUrl" value="detail?id=${member.id}" />
			<div class="flex items-center mt-10">
				<a href="${detailUrl}" class="font-bold">NO. ${member.id}</a> <a
					href="${detailUrl}" class="ml-2 font-light text-gray-600">${member.regDate}</a>
				<div class="flex-grow"></div>
				<a href="?authLevel=${member.authLevel}"
					class="cursor-pointer px-2 py-1 bg-${member.authLevelNameColor}-600 text-${member.authLevelNameColor}-100 font-bold rounded hover:bg-${member.authLevelNameColor}-500">${member.authLevelName}</a>
			</div>
			<div class="mt-2">
				<a href="${detailUrl}" class="mt-2 text-gray-600 block"> <span
					class="inline-flex justify-center items-center px-2 rounded-full bg-green-500 text-white">로그인
						아이디</span> <span>${member.loginId}</span>
				</a> <a href="${detailUrl}" class="mt-2 text-gray-600 block"> <span
					class="inline-flex justify-center items-center px-2 rounded-full bg-green-500 text-white">이름</span>
					<span>${member.name}</span>
				</a> <a href="${detailUrl}" class="mt-2 text-gray-600 block"> <span
					class="inline-flex justify-center items-center px-2 rounded-full bg-green-500 text-white">닉네임</span>
					<span>${member.nickname}</span>
				</a>
			</div>
			<div class="flex items-center mt-4">
				<a href="detail?id=${member.id}"
					class="text-blue-500 hover:underline" title="자세히 보기"> <span>
						<i class="fas fa-info"></i> <span class="hidden sm:inline">자세히
							보기</span>
				</span>
				</a> 
				<a href="modify?id=${member.id}"
					class="ml-2 text-blue-500 hover:underline"> <span> <i
						class="fas fa-edit"></i> <span class="hidden sm:inline">수정</span>
				</span>
				</a> 
				<a onclick="if ( !confirm('삭제하시겠습니까?') ) return false;"
					href="doDelete?id=${member.id}"
					class="ml-2 text-blue-500 hover:underline"> <span> <i
						class="fas fa-trash"></i> <span class="hidden sm:inline">삭제</span>
				</span>
				</a>
				<div class="flex-grow"></div>
				<div>
					<a class="flex items-center"> <img
						src="${member.writerThumbImgUrl}"
						alt="avatar" class="mx-4 w-10 h-10 object-cover rounded-full">
						<h1 class="text-gray-700 font-bold hover:underline">${member.nickname}</h1>
					</a>
				</div>
			</div>
		</c:forEach>
		<nav class="flex justify-center rounded-md shadow-sm mt-3" aria-label="Pagination">
			<c:if test="${page != 1}">
				<a href="${Util.getNewUrl(requestUrl, 'page', 1)}" class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50"> <span class="sr-only">Previous</span> <i class="fas fa-chevron-left"></i>
				</a>
			</c:if>
			<c:forEach var="i" begin="${pageMenuStart}" end="${pageMenuEnd}">
				<c:set var="aClassStr" value="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium" />
				<c:if test="${i == page}">
					<c:set var="aClassStr" value="${aClassStr} text-red-700 hover:bg-red-50" />
				</c:if>
				<c:if test="${i != page}">
					<c:set var="aClassStr" value="${aClassStr} text-gray-700 hover:bg-gray-50" />
				</c:if>
				<a href="${Util.getNewUrl(requestUrl, 'page', i)}" class="${aClassStr}">${i}</a>
			</c:forEach>
			<c:if test="${page != totalPage}">
				<a href="${Util.getNewUrl(requestUrl, 'page', totalPage)}" class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50"> <span class="sr-only">Next</span> <i class="fas fa-chevron-right"></i>
				</a>
			</c:if>
		</nav>
	</div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>