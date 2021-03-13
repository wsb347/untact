<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<script>
	param.boardId = parseInt("${board.id}");
</script>

<section class="section-1">
	<div class="bg-white shadow-md rounded container mx-auto p-8 mt-8">
		<div class="flex items-center">
			<script>
				$('.section-1 .select-board-id').val(param.boardId);

				$('.section-1 .select-board-id').change(function() {
					location.href = '?boardId=' + this.value;
				});
			</script>

			<div class="flex-grow"></div>

				</div>
		<div>
			<c:forEach items="${boards}" var="board">
				<c:set var="detailUrl" value="detail?id=${board.id}" />
				<div class="flex items-center mt-10">
					<a href="${detailUrl}" class="font-bold">NO. ${board.id}</a> <a
						href="${detailUrl}" class="ml-2 font-light text-gray-600">${board.regDate}</a>
					<div class="flex-grow"></div>
				</div>
				<div class="mt-2">
					<a href="${detailUrl}"
						class="text-2xl text-gray-700 font-bold hover:underline">${board.name}</a>
				</div>
				<div class="flex items-center mt-4">
					<a href="detail?id=${board.id}"
						class="text-blue-500 hover:underline">자세히 보기</a> <a
						href="modify?id=${board.id}"
						class="ml-2 text-blue-500 hover:underline">수정</a> <a
						onclick="if ( !confirm('삭제하시겠습니까?') ) return false;"
						href="doDelete?id=${board.id}"
						class="ml-2 text-blue-500 hover:underline">삭제</a>
					<div class="flex-grow"></div>

				</div>
			</c:forEach>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>