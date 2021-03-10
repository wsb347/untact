package com.sbs.untact.controller;

import java.util.List;
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
public class AdmMemberController extends BaseController {
	@Autowired
	private MemberService memberService;

	@RequestMapping("/adm/member/getLoginIdDup")
	@ResponseBody
	public ResultData getLoginIdDup(String loginId) {
		
		if(loginId == null) {
			return new ResultData("F-1", "loginId를 입력해주세요.");
		}
		
		if (Util.allNumberString(loginId)) {
			return new ResultData("F-3", "로그인아이디는 숫자만으로 구성될 수 없습니다.");
		}

		if (Util.startsWithNumberString(loginId)) {
			return new ResultData("F-4", "로그인아이디는 숫자로 시작할 수 없습니다.");
		}

		if (loginId.length() < 5) {
			return new ResultData("F-5", "로그인아이디는 5자 이상으로 입력해주세요.");
		}

		if (loginId.length() > 20) {
			return new ResultData("F-6", "로그인아이디는 20자 이하로 입력해주세요.");
		}

		if (Util.isStandardLoginIdString(loginId) == false) {
			return new ResultData("F-7", "로그인아이디는 영문소문자와 숫자의 조합으로 구성되어야 합니다.");
		}

		Member existingMember = memberService.getMemberByLoginId(loginId);

		if (existingMember != null) {
			return new ResultData("F-2", String.format("%s(은)는 이미 사용중인 로그인아이디 입니다.", loginId));
		}
		
		return new ResultData("S-1", String.format("%s(은)는 사용 가능한 아이디입니다.", loginId), "loginId", loginId);
	}
	
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

		if (memberService.isAdmin(existingMemberByLoginid) == false) {
			return Util.msgAndBack("관리자만 접근할 수 있는 페이지 입니다.");
		}

		session.setAttribute("loginedMemberId", existingMemberByLoginid.getId());

		String msg = String.format("%s님 환영합니다.", existingMemberByLoginid.getNickname());

		redirectUrl = Util.ifEmpty(redirectUrl, "../home/main");

		return Util.msgAndReplace(msg, redirectUrl);
	}

	@RequestMapping("/adm/member/modify")
	public String showModify(Integer id, HttpServletRequest req) {
		if (id == null) {
			return msgAndBack(req, "id를 입력해주세요.");
		}

		Member member = memberService.getForPrintMember(id);

		req.setAttribute("member", member);

		if (member == null) {
			return msgAndBack(req, "존재하지 않는 회원번호 입니다.");
		}

		return "adm/member/modify";
	}

	@RequestMapping("/adm/member/doModify")
	public String doModify(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		if (param.isEmpty()) {
			return Util.msgAndBack("수정할 정보를 입력해주세요.");
		}

		memberService.modifyMember(param);

		return msgAndReplace(req, "정보가 수정되었습니다.", "../member/list?authLevel=" + param.get("authLevel"));
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

	@RequestMapping("/adm/member/list")
	public String showList(HttpServletRequest req, String searchKeywordType, String searchKeyword,
			@RequestParam(defaultValue = "1") int page, @RequestParam Map<String, Object> param) {
		if (searchKeywordType != null) {
			searchKeywordType = searchKeywordType.trim();
		}

		if (searchKeywordType == null || searchKeywordType.length() == 0) {
			searchKeywordType = "nickname";
		}

		if (searchKeyword != null && searchKeyword.length() == 0) {
			searchKeyword = null;
		}

		if (searchKeyword != null) {
			searchKeyword = searchKeyword.trim();
		}

		if (searchKeyword == null) {
			searchKeywordType = null;
		}

		int itemsInAPage = 10;

		List<Member> members = memberService.getForPrintMembers(searchKeywordType, searchKeyword, page, itemsInAPage,
				param);

		req.setAttribute("members", members);

		return "adm/member/list";
	}

}
