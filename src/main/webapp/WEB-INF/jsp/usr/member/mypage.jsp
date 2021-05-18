<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.sbs.untact.util.Util"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<section class="section section-mypage px-2">
    <div class="container mx-auto">
        <div class="card bordered shadow-lg">
            <!-- 회원 아이템, first -->
            <div class="bg-white px-4 py-8">
                <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-3">
               		<div class="row-span-3 order-1">
                       	<img width="150px" class="rounded-full" src="${loginedMember.writerThumbImgUrl}" alt="User avatar">
                   	</div>
                	<div class="order-2">
                        <span class="badge badge-primary">번호</span>
                        <span>${loginedMember.id}</span>
                    </div>

                    <div class="cursor-pointer order-3">
                        <span class="badge badge-accent">회원타입</span>
                        <span>${loginedMember.authLevelName}</span>
                    </div>

                    <div class="order-4">
                        <span class="badge">등록날짜</span>
                        <span class="text-gray-600 text-light">${loginedMember.regDate}</span>
                    </div>

                    <div class="order-5">
                        <span class="badge">수정날짜</span>
                        <span class="text-gray-600 text-light">${loginedMember.updateDate}</span>
                    </div>

                    <div class="order-6">
                        <span class="badge">아이디</span>
                        <span class="text-gray-600">${loginedMember.loginId}</span>
                    </div>

                    <div class="order-7">
                        <span class="badge">이름</span>
                        <span class="text-gray-600">${loginedMember.name}</span>
                    </div>

                    <div class="order-8 sm:order-4 md:order-8">
                        <span class="badge">닉네임</span>
                        <span class="text-gray-600">${loginedMember.nickname}</span>
                    </div>
                </div>

                <div class="grid grid-item-float gap-3 mt-4">
                	<c:set var="modifyUrl" value="modify?id=${loginedMember.id}&checkPasswordAuthCode=${checkPasswordAuthCode}"/>
                    <a href="../member/checkPassword?afterUri=${Util.getUrlEncoded(modifyUrl)}" class="text-blue-500 hover:underline">
                        <span>
                            <i class="fas fa-edit"></i>
                            <span>수정</span>
                        </span>
                    </a>
                    <a onclick="if ( !confirm('탈퇴하시겠습니까?') ) return false;" href="doDelete?id=${loginedMember.id}" class="text-blue-500 hover:underline">
                        <span>
                            <i class="fas fa-trash"></i>
                            <span>탈퇴</span>
                        </span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>