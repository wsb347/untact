<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<section class="section-1 flex-grow">
	<div class="bg-white shadow-md rounded container mx-auto p-8 mt-8">
		<div class="flex h-full">
	    	<a class="w-full font-bold py-2 w-1/12 mx-3 rounded" target="_blank" href="https://untact.popol.site/swagger-ui/index.html">
	    		<img class="inline-block" width="150px" src="https://www.redspark.io/wp-content/uploads/2020/04/imagem_swagger.png" />
	    		  스웨거 커뮤니티 사이트
	    	</a>
        </div>
        
        <div class="mt-4">
        	<h1 class="text-2xl">최신글 보기</h1>
        	<c:forEach items="${articles}" var="article">
				<div class="flex items-center mt-2">
					<a href="../article/detail?id=${article.id}" class="font-bold">NO. ${article.id}</a> 
					<a href="../article/detail?id=${article.id}" class="ml-6 flex-grow hover:underline">${article.title}</a>
					<a href="../article/detail?id=${article.id}" class="font-light text-gray-600 hidden md:block">${article.regDate}</a>
					<a href="../article/list?boardId=${article.boardId}" class="ml-6 px-2 py-1 bg-gray-600 text-gray-100 font-bold rounded px-3 hover:bg-gray-500">${article.extra__boardName}</a>
				</div>
			</c:forEach>
        </div>
        
        <div class="flex-grow"></div>
    </div>
</section>
<%@ include file="../part/mainLayoutFoot.jspf"%>