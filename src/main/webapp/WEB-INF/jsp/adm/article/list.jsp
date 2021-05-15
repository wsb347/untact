<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sbs.untact.util.Util"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/mainLayoutHead.jspf"%>
<script>
	if(${board.id == 0}){
		${board.id} == '';
	}
	param.boardId = parseInt("${board.id}");
</script>
<section class="section-1">
	<div class="bg-white shadow-md rounded container mx-auto p-8 mt-8">
		<div>총 게시물 수 : ${Util.numberFormat(totalItemsCount)}개</div>
		
		<form class="flex mt-3">
			<select name="searchKeywordType">
				<option value="titleAndBody">전체</option>
				<option value="title">제목</option>
				<option value="body">본문</option>
			</select> <input class="ml-3 shadow appearance-none border rounded w-full py-2 px-5 text-grey-darker" name="searchKeyword" type="text" placeholder="검색어를 입력해주세요." value="${param.searchKeyword}" /> <input class="ml-3 btn-primary bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded" type="submit" value="검색" />
			<script>
				if ( param.searchKeywordType ) {
					$('.section-1 select[name="searchKeywordType"]').val(param.searchKeywordType);
				}
			</script>
			<a href="add?boardId=${board.id }" class="bg-blue-500 hover:bg-blue-600 text-white text-center font-bold py-2 px-4 w-1/12 mx-3 rounded">글쓰기</a>
		</form>
		
		<c:forEach items="${articles}" var="article">
			<c:set var="detailUrl" value="detail?id=${article.id}" />
			<c:set var="thumbFileNo" value="${String.valueOf(1)}" />
			<c:set var="thumbFile" value="${article.extra.file__common__attachment[thumbFileNo]}" />
			<c:set var="thumbUrl" value="${thumbFile.getForPrintUrl()}" />
			<div class="flex items-center mt-10">
				<a href="${detailUrl}" class="font-bold">NO. ${article.id}</a> <a href="${detailUrl}" class="ml-2 font-light text-gray-600">${article.regDate}</a>
				<div class="flex-grow"></div>
				<a href="list?boardId=${article.boardId}" class="px-2 py-1 bg-gray-600 text-gray-100 font-bold rounded px-3 hover:bg-gray-500">${article.extra__boardName}</a>

			</div>
			<div class="mt-2">
				<a href="${detailUrl}" class="text-2xl text-gray-700 font-bold hover:underline">${article.title}</a>
				<c:if test="${thumbUrl != null}">
					<a class="block" href="${detailUrl}"> <img class="max-w-xs" src="${thumbUrl}" alt="" />
					</a>
				</c:if>
				<a href="${detailUrl}" class="mt-2 text-gray-600 block">${article.body}</a>
			</div>
			<div class="flex justify-between items-center mt-4">
				<a href="detail?id=${article.id}" class="text-blue-500 hover:underline">자세히 보기</a>
				<a href="modify?id=${article.id}" class="ml-2 text-blue-500 hover:underline">수정</a>
				<a onclick="if ( !confirm('삭제하시겠습니까?') ) return false;" href="doDelete?id=${article.id}" class="ml-2 text-blue-500 hover:underline">삭제</a>
				<div class="flex-grow"></div>
				<div>
					<a class="flex items-center"><img src="${article.writerThumbImgUrl}" alt="avatar" class="mx-4 w-10 h-10 object-cover rounded-full">
						<h1 class="text-gray-700 font-bold">${article.extra__writer}</h1> </a>
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