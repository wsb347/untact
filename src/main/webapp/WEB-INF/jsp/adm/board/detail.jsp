<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.sbs.untact.util.Util"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<section class="section-1">
	<div class="bg-white shadow-md rounded container mx-auto p-8 mt-8">
		<div class="w-full">
			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28">
					<span>코드</span>
				</div>
				<div class="lg:flex-grow">
					<h1>${board.code}</h1>
				</div>
			</div>
			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28">
					<span>이름</span>
				</div>
				<div class="lg:flex-grow">
					<h1>${board.name}</h1>
				</div>
			</div>
			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28">
					<span>글 갯수</span>
				</div>
				<div class="lg:flex-grow">
					<h1>${Util.numberFormat(totalItemsCount)} 개</h1>
				</div>
			</div>
		</div>
		<div class="form-row flex flex-col lg:flex-row mt-5">
			<div class="lg:flex-grow">
				<div class="btns">
					<input onclick="history.back();" type="button" class="btn-info bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded" value="목록">
				</div>
			</div>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>