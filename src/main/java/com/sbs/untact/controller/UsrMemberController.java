package com.sbs.untact.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.untact.dto.Member;
import com.sbs.untact.dto.ResultData;
import com.sbs.untact.service.MemberService;

@Controller
public class UsrMemberController {
	@Autowired
	private MemberService memberService;

	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public ResultData doJoin(@RequestParam Map<String, Object> param) {
		Member existingMemberByLoginid = memberService.getMemberByLoginId((String) param.get("loginId"));
		Member existingMemberByNickname = memberService.getMemberByNickname((String) param.get("nickname"));

		if (existingMemberByLoginid != null) {
			return new ResultData("F-2", String.format("%s (은)는 이미 사용중인 로그인아이디입니다.", param.get("loginId")));
		}

		if (existingMemberByNickname != null) {
			return new ResultData("F-2", String.format("%s (은)는 이미 사용중인 닉네임입니다.", param.get("nickname")));
		}

		if (param.get("loginId") == null) {
			return new ResultData("F-1", "loginId(을)를 입력해주세요.");
		}

		if (param.get("loginPw") == null) {
			return new ResultData("F-1", "loginPw(을)를 입력해주세요.");
		}

		if (param.get("nickname") == null) {
			return new ResultData("F-1", "nickname(을)를 입력해주세요.");
		}

		if (param.get("name") == null) {
			return new ResultData("F-1", "name(을)를 입력해주세요.");
		}

		if (param.get("cellphoneNo") == null) {
			return new ResultData("F-1", "cellphoneNo(을)를 입력해주세요.");
		}

		if (param.get("email") == null) {
			return new ResultData("F-1", "email(을)를 입력해주세요.");
		}

		return memberService.memberJoin(param);
	}

	@RequestMapping("/usr/member/doLogin")
	@ResponseBody
	public ResultData doLogin(String loginId, String loginPw, HttpSession session) {
		Member existingMemberByLoginid = memberService.getMemberByLoginId(loginId);

		System.out.println("로그인 정보 : " + session.getAttribute("loginedMemberId"));

		if (existingMemberByLoginid == null) {
			return new ResultData("F-2", String.format("%s (은)는 존재하지않는 아이디입니다.", loginId));
		}

		if (loginId == null) {
			return new ResultData("F-1", "loginId(을)를 입력해주세요.");
		}

		if (existingMemberByLoginid.getLoginPw().equals(loginPw) == false) {
			return new ResultData("F-3", "비밀번호가 일치하지 않습니다.");
		}

		session.setAttribute("loginedMemberId", existingMemberByLoginid.getId());

		return new ResultData("T-1", String.format("%s님 환영합니다.", existingMemberByLoginid.getNickname()));
	}

	@RequestMapping("/usr/member/doLogout")
	@ResponseBody
	public ResultData doLogout(HttpSession session) {
		session.removeAttribute("loginedMemberId");

		return new ResultData("T-1", "로그아웃 되었습니다.");
	}

	@RequestMapping("/usr/member/doModify")
	@ResponseBody
	public ResultData doModify(@RequestParam Map<String, Object> param, HttpSession session) {
		if (param.isEmpty()) {
			return new ResultData("F-2", "수정할 정보를 입력해주세요.");
		}

		int loginedMemberId = (int) session.getAttribute("loginedMemberId");
		param.put("id", loginedMemberId);

		return memberService.modifyMember(param);
	}

}
