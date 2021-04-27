<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.sbs.untact.util.Util"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<section class="section-1">
	<div class="bg-white shadow-md rounded container mx-auto p-8 mt-8">
		<div class="w-full">
			<div class="flex flex-row mt-2 py-3">
				<div class="rounded-full border-2 border-pink-500">
					<img class="w-12 h-12 object-cover rounded-full shadow cursor-pointer" alt="User avatar" src="${member.writerThumbImgUrl}">
				</div>
				<div class="flex flex-col mb-2 ml-4 mt-1">
					<div class="text-gray-600 text-sm font-semibold">${member.nickname}</div>
					<div class="flex w-full mt-1">
						<div class="text-gray-400 font-thin text-xs">${member.regDate}</div>
					</div>
				</div>
			</div>
			<div class="border-b border-gray-100"></div>
			<div class="text-gray-400 font-medium text-sm mb-7 mt-6">
				<c:set var="fileNo" value="${String.valueOf(1)}" />
				${member.extra.file__common__attachment[fileNo].mediaHtml}
			</div>
			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28">
					<span>아이디</span>
				</div>
				<div class="lg:flex-grow">${member.loginId}</div>
			</div>
			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28">
					<span>관리자권한</span>
				</div>
				<div class="lg:flex-grow">${member.authLevelName}</div>
			</div>
			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28">
					<span>닉네임</span>
				</div>
				<div class="lg:flex-grow">${member.nickname}</div>
			</div>
			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28">
					<span>이름</span>
				</div>
				<div class="lg:flex-grow">${member.name}</div>
			</div>
			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28">
					<span>전화번호</span>
				</div>
				<div class="lg:flex-grow">${member.cellphoneNo}</div>
			</div>
			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex lg:items-center lg:w-28">
					<span>이메일</span>
				</div>
				<div class="lg:flex-grow">${member.email}</div>
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