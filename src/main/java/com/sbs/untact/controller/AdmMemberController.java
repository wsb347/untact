package com.sbs.untact.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.untact.dto.Member;
import com.sbs.untact.dto.ResultData;
import com.sbs.untact.service.MemberService;
import com.sbs.untact.util.Util;

@Controller
public class AdmMemberController {
	@Autowired
	private MemberService memberService;

	@RequestMapping("/adm/member/login")
	public String login() {
		return "adm/member/login";
	}

	@RequestMapping("/adm/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw, String redirectUrl, HttpSession session) {
		Member existingMemberByLoginid = memberService.getMemberByLoginId(loginId);

		System.out.println("로그인 정보 : " + session.getAttribute("loginedMemberId"));

		if (existingMemberByLoginid == null) {
			return Util.msgAndBack(String.format("%s (은)는 존재하지않는 아이디입니다.", loginId));
		}

		if (loginId == null) {
			return Util.msgAndBack("loginId(을)를 입력해주세요.");
		}

		if (existingMemberByLoginid.getLoginPw().equals(loginPw) == false) {
			return Util.msgAndBack("비밀번호가 일치하지 않습니다.");
		}

		if (memberService.inAdim(existingMemberByLoginid) == false) {
			return Util.msgAndBack("관리자만 접근할 수 있는 페이지 입니다.");
		}

		session.setAttribute("loginedMemberId", existingMemberByLoginid.getId());

		String msg = String.format("%s님 환영합니다.", existingMemberByLoginid.getNickname());
		
		redirectUrl = Util.ifEmpty(redirectUrl,"../home/main");
		
		return Util.msgAndReplace(msg, redirectUrl);
	}

	@RequestMapping("/adm/member/doModify")
	@ResponseBody
	public ResultData doModify(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		if (param.isEmpty()) {
			return new ResultData("F-2", "수정할 정보를 입력해주세요.");
		}

		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		param.put("id", loginedMemberId);

		return memberService.modifyMember(param);
	}
	
	@RequestMapping("/adm/member/doLogout")
	@ResponseBody
	public String doLogout(HttpSession session) {
		session.removeAttribute("loginedMemberId");

		return Util.msgAndReplace("로그아웃 되었습니다.", "../member/login");
	}
	
	@RequestMapping("/adm/member/join")
	public String join() {
		return "adm/member/join";
	}
	
	@RequestMapping("/adm/member/doJoin")
	@ResponseBody
	public String doJoin(@RequestParam Map<String, Object> param) {
		Member existingMember = memberService.getMemberByLoginId((String) param.get("loginId"));
		Member existingMemberByNickname = memberService.getMemberByNickname((String) param.get("nickname"));

		if (existingMember != null) {
			return Util.msgAndBack(String.format("%s (은)는 이미 사용중인 로그인아이디입니다.", param.get("loginId")));
		}

		if (existingMemberByNickname != null) {
			return Util.msgAndBack(String.format("%s (은)는 이미 사용중인 닉네임입니다.", param.get("nickname")));
		}

		if (param.get("loginId") == null) {
			return Util.msgAndBack("loginId(을)를 입력해주세요.");
		}

		if (param.get("loginPw") == null) {
			return Util.msgAndBack("loginPw(을)를 입력해주세요.");
		}

		if (param.get("nickname") == null) {
			return Util.msgAndBack("nickname(을)를 입력해주세요.");
		}

		if (param.get("name") == null) {
			return Util.msgAndBack("name(을)를 입력해주세요.");
		}

		if (param.get("cellphoneNo") == null) {
			return Util.msgAndBack("cellphoneNo(을)를 입력해주세요.");
		}

		if (param.get("email") == null) {
			return Util.msgAndBack("email(을)를 입력해주세요.");
		}

		memberService.memberJoin(param);
		
		return Util.msgAndReplace("회원가입 되었습니다.", "../member/login");
		}

}
