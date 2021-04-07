package com.sbs.untact.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.untact.dao.MemberDao;
import com.sbs.untact.dto.GenFile;
import com.sbs.untact.dto.Member;
import com.sbs.untact.dto.ResultData;
import com.sbs.untact.util.Util;

@Service
public class MemberService {
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private GenFileService genFileService;
	
	// static 시작

	public static String getAuthLevelName(Member member) {
		switch ( member.getAuthLevel() ) {
		case 7:
			return "관리자";
		case 3:
			return "일반";
		default:
			return "유형정보없음";
		}
	}

	public static String getAuthLevelNameColor(Member member) {
		switch ( member.getAuthLevel() ) {
		case 7:
			return "red";
		case 3:
			return "gray";
		default:
			return "";
		}
	}

	// static 끝


	public ResultData memberJoin(Map<String, Object> param) {
		memberDao.memberJoin(param);
		int id = Util.getAsInt(param.get("id"), 0);

		genFileService.changeInputFileRelIds(param, id);
		
		return new ResultData("S-1", "성공하였습니다.");
	}

	public Member getMember(int id) {
		return memberDao.getMember(id);
	}

	public Member getMemberByLoginId(String loginId) {
		return memberDao.getMemberByLoginId(loginId);
	}

	public Member getMemberByNickname(String nickname) {
		return memberDao.getMemberByNickname(nickname);
	}

	public ResultData modifyMember(Map<String, Object> param) {
		memberDao.modifyMember(param);
		return new ResultData("S-1", "회원정보가 수정되었습니다.");
	}

	public boolean isAdmin(Member actor) {
		return actor.getAuthLevel() == 7;
	}

	public Member getMemberByAuthKey(String authKey) {
		return memberDao.getMemberByAuthKey(authKey);
	}

	public List<Member> getMembers() {
		return memberDao.getMembers();
	}

	public List<Member> getForPrintMembers(Integer authLevel, String searchKeywordType, String searchKeyword, int page, int itemsInAPage,
			Map<String, Object> param) {
		int limitStart = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;
		
		param.put("searchKeywordType", searchKeywordType);
		param.put("searchKeyword", searchKeyword);
		param.put("limitStart", limitStart);
		param.put("limitTake", limitTake);

		return memberDao.getForPrintMembers(param);

	}

	public Member getForPrintMember(int id) {
		return memberDao.getForPrintMember(id);
	}

	public Member getForPrintMemberByAuthKey(String authKey) {
		Member member = memberDao.getMemberByAuthKey(authKey);

		updateForPrint(member);

		return member;
	}

	private void updateForPrint(Member member) {
		GenFile genFile = genFileService.getGenFile("member", member.getId(), "common", "attachment", 1);

		if (genFile != null) {
			String imgUrl = genFile.getForPrintUrl();
			member.setExtra__thumbImg(imgUrl);
		}
	}

	public Member getForPrintMemberByLoginId(String loginId) {
		Member member = memberDao.getMemberByLoginId(loginId);

		updateForPrint(member);

		return member;
	}

	public ResultData deleteMember(Integer id) {
		memberDao.deleteMember(id);

		genFileService.getGenFilesByRelTypeCodeAndRelId("member", id);

		return new ResultData("S-1", "삭제하였습니다.", "id", id);
	}

	public Member getMemberByAuthLevel(Integer authLevel) {
		return memberDao.getMemberByAuthLevel(authLevel);
	}

	public int getMemberTotalCount(Integer authLevel, String searchKeywordType, String searchKeyword) {
		return memberDao.getMemberTotalCount(authLevel,searchKeywordType,searchKeyword);
		}


}
